import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components'
import { GoogleMap, LoadScript, StreetViewPanorama, StreetViewService } from '@react-google-maps/api';

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

function Map(props) {
  const googleMapsApiKey = props.google_streetview_key
  const [position, setPosition] = React.useState(null);
  const [city, setCity] = React.useState(null)
  const [streetViewService, setstreetViewService] = React.useState(null)
  const [answer, setAnswer] = React.useState({name:''})
  const [answers, setAnswers] = React.useState([])
  const [timer, setTimer] = React.useState(9);

  const getCity = (cities) => {
    const candidate = cities[parseInt(random(0, cities.length))]
    const shortName = candidate.name.substring(0, candidate.name.indexOf(","));
    const city = ({ name: shortName.toLowerCase() })
    setAnswer(city)
    setAnswers(answers => [...answers, city]);
    return candidate
  }

  const processStreetViewData = (data, status, streetViewService, city) => {
    if (status === "OK") {
      guessed.push(city)
      const position = {lat: data.location.latLng.lat(), lng: data.location.latLng.lng()}
      setPosition(position)
    } else {
      getPanorama(streetViewService, city, radius.lax, 'nearest')
    }
  }

  const formatClock = (t) => {
    let minutes = parseInt(t / 60, 10)
    let seconds = parseInt(t % 60, 10);
    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;
    return `${minutes}:${seconds}`
  }

  const next = (streetViewService) => {
    startTimer(16, streetViewService)
    const city = getCity(props.cities)
    getPanorama(streetViewService, city, radius.stringent, 'best')
  }

  const startTimer = (t,streetViewService) => {
    const x = setInterval(function () {
        setTimer(t--)
        if (t < 0) {
            setTimer(0)
            clearInterval(x)
            next(streetViewService)
        }
    }, 1000);
}

  const getPanorama = (streetViewService, city, radius, preference) => {
    const location = randomLocation(city, radius)
    streetViewService.getPanorama({
      location: location,
      radius: radius,
      preference: preference,
    }, (data, status ) => {
      processStreetViewData(data, status, streetViewService, city)
    })
  }

  const onLoad = (streetViewService) => {
    startTimer(timer, streetViewService)
    const city = getCity(props.cities)
    getPanorama(streetViewService, city, radius.stringent, 'best')
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
        <div className="timer">{formatClock(timer)}</div>
        <div className="answer">{answer.name}</div>
        <div>{answers.map(entry =>
          <div key={entry.name}>{entry.name}</div>
        )}
        </div>

      </Below>
    </LoadScript>
    </div>
  );
}

Map.propTypes = {
  cities: PropTypes.arrayOf(PropTypes.object).isRequired,
};

export default Map;
