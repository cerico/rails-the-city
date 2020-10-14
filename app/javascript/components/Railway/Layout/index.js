import React from 'react'
import { push } from 'connected-react-router'
import styled from 'styled-components'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'

const Container = styled.div`
  background: orange;
  height: 50vh;
`

class Layabout extends React.Component {
  render() {
    return (
      <Container>
        Layout
        {this.props.children}
      </Container>
    )
  }
}

Layabout.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.node),
    PropTypes.node,
  ]).isRequired,
  go: PropTypes.func.isRequired,
}

const mapStateToProps = (state) => ({
  active: state.routerLocations.current.pathname,
})

const mapDispatchToProps = (dispatch) => ({
  go: (e) => {
    dispatch(push(e))
  },
})

export default connect(mapStateToProps, mapDispatchToProps)(Layabout)
