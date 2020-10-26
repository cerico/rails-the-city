import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components'
import { GoogleMap, LoadScript, StreetViewPanorama, StreetViewService } from '@react-google-maps/api';
import { apiBase, makePostRequest } from './api'

const random = (min, max) => (
  Math.random() * (max - min) + min
)

const radius = {
  stringent: 100,
  lax: 500
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

const Scores = styled.div`
  display: flex;
  div {
    flex: 1
  }
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
  const [timer, setTimer] = React.useState(100);
  const [svs, setSvs] = React.useState(null);
  const [correct, setCorrect] = React.useState(false)
  const [score, setScore] = React.useState(null)
  const [totalScore, setTotalScore] = React.useState(null)
  const [playing, setPlaying] = React.useState(true)
  const [inputValue, setInputValue] = React.useState("")
  const [scores, setScores] = React.useState([])
  const [double, setDouble] = React.useState(false);

  const calcScore = (t) => (
    t > 135 ? 100 : parseInt(t / 1.35)
  )

  React.useEffect(() => {
    if (cities.length > 0) {
      setCity(getCity(cities))
    }
  }, [cities])

  React.useEffect(() => {
    if (city) {
      getPanorama(city, radius.stringent, 'best')
    }
  }, [city])

  React.useEffect(() => {
    let interval = null;
    if (correct || timer < 1) {
      if (answers.length < 9) {
        let filteredArray = cities.filter(item => item.name !== city.name)
        setCities(filteredArray)
      }
      setAnswers(answers => [...answers, {name: city.shortName, score: score || 0}]);
      setTotalScore(totalScore + score)
      setCorrect(false)
      setScore(null)
      setTimer(100)
      setDouble(false)
    } else {
      interval = setInterval(() => {
        setTimer(timer => timer - 1);
      }, 1000);
    }
    if (answers.length === 10) {
      setPlaying(false)
      async function increment(counter) {
        const data = { name: 'anonymous', value: counter }
        const endpoint = `${apiBase}/api/v1/counters/update`
        const response = await makePostRequest(endpoint, data)
        const result = await response.json()
        try {
          const newScores = [ ...scores, result].sort((a, b) => b.value - a.value).slice(0,10)
          setScores(newScores)
        } catch (error) {
          console.log(error)
        }
      }
      increment(totalScore)
      return clearInterval(interval)
    }
    return () => clearInterval(interval);
   }, [answer, city, answers, svs, timer, position, cities, correct]);

  const onChangeHandler = (event) => {
    if (event.target.value.toLowerCase() === city.shortName) {
      setCorrect(true)
      const roundScore = calcScore(timer)
      setScore(roundScore)
      return setInputValue('');
    }
    setInputValue(event.target.value);
  };


  const getCity = (cs) => {
    const candidate = cs[parseInt(random(0, cs.length))]
    const shortName = candidate.name.substring(0, candidate.name.indexOf(","));
    return ({ ...candidate, shortName: shortName.toLowerCase() })
  }

  const processStreetViewData = (city, data, status) => {
    if (status === "OK") {
      const position = {lat: data.location.latLng.lat(), lng: data.location.latLng.lng()}
      setPosition(position)
    } else {
      getPanorama(city, radius.lax, 'nearest')
    }
  }

  const formatClock = (t) => {
    let minutes = parseInt(t / 60, 10)
    let seconds = parseInt(t % 60, 10);
    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;
    return `${minutes}:${seconds}`
  }

  const getPanorama = (city, radius, preference) => {
    const location = randomLocation(city, radius)
    svs.getPanorama({
      location: location,
      radius: radius,
      preference: preference,
    }, (data, status ) => {
      processStreetViewData(city, data, status)
    })
  }

  const resetTimer = () => (setTimer(0)) 

  const onLoad = (streetViewService) => {
    setSvs(streetViewService);
    setScores(props.scores)
    setCities(props.cities);
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
      {playing && <Below>
        <div className="timer">{formatClock(timer)}</div>
        <input
          type="text"
          name="name"
          onChange={(e)=> onChangeHandler(e, svs)}
          value={inputValue}
        />
      </Below>}
      <Scores>
        <div>
          <div>{answers.map(entry =>
            <div key={entry.name}>{entry.name} - {entry.score}</div>
          )}
          </div>
          <div>{totalScore}</div>
        </div>
        <div>
          {playing && (
            <button
              disabled={double}
              onClick={() => {
                resetTimer()
                setDouble(true);
              }}
              >Skip</button>
          )}
          <div>{scores.map(s => <div key={s.id}>{s.value}</div>)}</div>
        </div>
      </Scores>
    </LoadScript>
    </div>
  );
}

Map.propTypes = {
  cities: PropTypes.arrayOf(PropTypes.object).isRequired,
};

export default Map;
