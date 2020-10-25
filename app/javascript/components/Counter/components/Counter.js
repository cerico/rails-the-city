import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components'
import { GoogleMap, LoadScript, StreetViewPanorama, StreetViewService } from '@react-google-maps/api';
import { END } from 'redux-saga';

const random = (min, max) => (
  Math.random() * (max - min) + min
)

const guessed = []

const radius = {
  stringent: 50,
  lax: 1000
}

const locator = (origin) => {
  const radius = 0.25
  const xOffset = random(-radius, radius)
  const yOffset = random(-radius,radius)
  return {lat: origin.lat + xOffset, lng: origin.lng + yOffset}
}

const randomLocation = (city) => locator(city)

const containerStyle = {
  flex: '1',
  height: '80vh',
};

const Below = styled.div`
  font-size: 44px;
`

const streetViewOptions = {
  motionTracking: true,
  motionTrackingControl: true,
  enableCloseButton: false,
  linksControl: false,
  panControlOptions: false,
  fullscreenControl: false,
  zoomControl: true,
  pov: {
    heading: 0,
    pitch: 10,
    zoom: 0,
  }, showRoadLabels: false,
  clickToGo: true,
  addressControl: false,
  addressControlOptions: false,
}

const Map = (props) => {
  const googleMapsApiKey = props.google_streetview_key
  const [position, setPosition] = React.useState(null)
  const [city, setCity] = React.useState(null)
  const [answer, setAnswer] = React.useState({})
  const [answers, setAnswers] = React.useState([])
  const [cities, setCities] = React.useState([])
  const [timer, setTimer] = React.useState(8);
  const [svs, setSvs] = React.useState(null);
  const [correct, setCorrect] = React.useState(false)
  const [score, setScore] = React.useState(null)
  const [totalScore, setTotalScore] = React.useState(null)
  const [playing, setPlaying] = React.useState(true)
  const [inputValue, setInputValue] = React.useState("")

  const calcScore = (t) => (
    t > 135 ? 100 : parseInt(t / 1.35)
  )

  React.useEffect(() => {
    if (svs) {
      console.log(svs)
      next()
    }
  }, [svs])


  React.useEffect(() => {
    let interval = null;
    if (correct || timer < 1) {
      setTimer(8)
      setAnswers(answers => [...answers, {name: city.shortName, score: score || 0}]);
      setCorrect(false)
      setScore(null)
      const newCity = getCity(cities)
      setCity(newCity)
      if (answers.length < 8) {
        console.log(answers.length)
        next()
      }
    } else {
      interval = setInterval(() => {
        setTimer(timer => timer - 1);
      }, 1000);
    }
    if (answers.length === 10) {
      setPlaying(false)
      return clearInterval(interval)
    }
    return () => clearInterval(interval);
   }, [answer, city, answers, svs, timer, position, cities, correct]);

  const onChangeHandler = (event) => {
    if (event.target.value.toLowerCase() === city.shortName) {
      setCorrect(true)
      const roundScore = calcScore(timer)
      setScore(roundScore)
      setTotalScore(totalScore + roundScore)
      return setInputValue('');
    }
    setInputValue(event.target.value);
  };

  const getCity = (cs) => {
    const candidate = cs[parseInt(random(0, cs.length))]
    let filteredArray = cs.filter(item => item !== candidate)
    setCities(filteredArray)
    const shortName = candidate.name.substring(0, candidate.name.indexOf(","));
    const city = ({ ...candidate, shortName: shortName.toLowerCase() })
    setCity(city)
    return city
  }

  const processStreetViewData = (data, status) => {
    console.log(status)
    if (status === "OK") {
      const position = {lat: data.location.latLng.lat(), lng: data.location.latLng.lng()}
      setPosition(position)
    } else {
      getPanorama(radius.lax, 'nearest')
    }
  }

  const formatClock = (t) => {
    let minutes = parseInt(t / 60, 10)
    let seconds = parseInt(t % 60, 10);
    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;
    return `${minutes}:${seconds}`
  }

  const next = () => {
    getPanorama(radius.stringent, 'best')
  }

  const getPanorama = (radius, preference) => {
    const location = randomLocation(city, radius)
    svs.getPanorama({
      location: location,
      radius: radius,
      preference: preference,
    }, (data, status ) => {
      processStreetViewData(data, status)
    })
  }

  const onLoad = (streetViewService) => {
    setSvs(streetViewService);
    setCities(props.cities);
    const city = getCity(props.cities)
    setCity(city)
  }

  return (
    <div>
    <LoadScript googleMapsApiKey={googleMapsApiKey}>
      <GoogleMap mapContainerStyle={containerStyle}>
        <StreetViewService onLoad={onLoad} />
        <StreetViewPanorama
          position={position}
          visible
          options={streetViewOptions}
        />
      </GoogleMap>
      <Below>
        <div className="timer">{playing && formatClock(timer)}</div>
        <input
          type="text"
          name="name"
          onChange={(e)=> onChangeHandler(e, svs)}
          value={inputValue}
        />
        <div>{answers.map(entry =>
          <div key={entry.name}>{entry.name} - {entry.score}</div>
        )}
        </div>
        <div>{totalScore}</div>
      </Below>
    </LoadScript>
    </div>
  );
}

Map.propTypes = {
  cities: PropTypes.arrayOf(PropTypes.object).isRequired,
};

export default Map;
