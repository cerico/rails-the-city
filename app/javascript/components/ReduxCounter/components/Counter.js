import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { increment } from '../actions'

const Counter = ({ counter, increment } ) => (
  <div>
    <div>Clicked: {counter.value} times</div>
    <div>
      <button onClick={() => increment({ ...counter, value: counter.value + 1})}>+</button>
      <button onClick={() => increment({ ...counter, value: counter.value - 1})}>-</button>
    </div>
  </div>
)

Counter.propTypes = {
  counter: PropTypes.object.isRequired,
  increment: PropTypes.func.isRequired
}

const mapStateToProps = (state) => ({
  counter: state.counter,
})

const mapDispatchToProps = (dispatch) => ({
  increment: (data) => {
    dispatch(increment(data))
  },
})

export default connect(mapStateToProps, mapDispatchToProps)(Counter)
