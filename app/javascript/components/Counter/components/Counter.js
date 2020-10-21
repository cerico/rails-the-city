import React from 'react';
import PropTypes from 'prop-types';
import { GoogleMap, LoadScript, StreetViewPanorama, StreetViewService } from '@react-google-maps/api';

const random = (min, max) => (
  Math.random() * (max - min) + min
)

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
  height: '100vh',
};

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

  const processStreetViewData = (data, status, streetViewService) => {
    if (status === "OK") {
      const position = {lat: data.location.latLng.lat(), lng: data.location.latLng.lng()}
      setPosition(position)
    } else {
      getPanorama(streetViewService, radius.lax, 'nearest')
    }
  }

  const getPanorama = (streetViewService, radius, preference) => {
    const city = props.cities[parseInt(random(0, props.cities.length))]
    const location = randomLocation(city, radius)
    streetViewService.getPanorama({
      location: location,
      radius: radius,
      preference: preference,
    }, (data, status ) => {
      processStreetViewData(data, status, streetViewService)
    })
  }

  const onLoad = (streetViewService) => {
    getPanorama(streetViewService, radius.stringent, 'best')
  }

  return (
    <LoadScript googleMapsApiKey={googleMapsApiKey}>
      <GoogleMap mapContainerStyle={containerStyle}>
        <StreetViewService onLoad={onLoad} />
        <StreetViewPanorama
          position={position}
          visible
          options={streetViewOptions}
        />
      </GoogleMap>
    </LoadScript>
  );
}

Map.propTypes = {
  cities: PropTypes.arrayOf(PropTypes.object).isRequired,
};

export default Map;
