import React from 'react'
import styled from 'styled-components'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { push } from 'connected-react-router'

const Container = styled.div`
  background: pink;
`

const Page = (props) => (
  <Container className="row">
    {props.cities.length > 0 && props.cities[0].name}
  </Container>
)

Page.propTypes = {
  cities: PropTypes.array,
  go: PropTypes.func.isRequired,
}

Page.defaultProps = {
  cities: []
}

const mapStateToProps = (state) => ({
  cities: state.cities,
})

const mapDispatchToProps = (dispatch) => ({
  go: (e) => {
    dispatch(push(`payments/${e}`))
  },
})

export default connect(mapStateToProps, mapDispatchToProps)(Page)
