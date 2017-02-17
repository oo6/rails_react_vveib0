import React, { Component } from 'react';
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { Spin } from 'antd';
import { Button } from 'antd';

import * as testActionCreators from '../actions/test'

class Test extends Component {
  constructor(props) {
    super(props)
    this.click = this.click.bind(this)

    this.state = {
      isLoading: false
    }
  }

  click() {
    this.setState({ isLoading: true })

    this.props.testActions.hi()
      .then(() => this.setState({ isLoading: false }))
      .catch(() => this.setState({ isLoading: false }))
  }

  render() {
    const { isLoading } = this.state

    if (isLoading) {
      return <Spin />
    }

    return (
      <div>
        <Button onClick={ this.click }>click</Button>
        <p>{ this.props.test.text }</p>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    test: state.test
  }
}

function mapDispatchToProps(dispatch) {
  return {
    testActions: bindActionCreators(testActionCreators, dispatch)
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Test)
