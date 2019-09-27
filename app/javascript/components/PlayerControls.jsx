import React from "react";
import PropTypes from "prop-types";

import ErrorMessage from "./ErrorMessage";
import Loading from "./Loading";

class PlayerControls extends React.Component {
  constructor(props) {
    super(props);
    this.state = props; // TODO remove; we should not be setting state from props directly
  }

  move(dx, dy) {
    // This only sets state; it doesn't actually call the server or
    // send prop updates to anything. We'll need to pass references
    // up the chain or something...
    this.setState(state => ({
      world: {
        x: state.world.x + dx,
        y: state.world.y + dy,
      }
    }));
  }

  moveUp = () => {
    return this.move(0, -1);
  };

  render() {
    return (
      <>
        <button onClick={this.moveUp}>Up</button>

        <small>({this.state.world.x}, {this.state.world.y})</small>
      </>
    );
  }
}

PlayerControls.propTypes = {
  id:     PropTypes.number.isRequired,
  world:  PropTypes.shape({
    id: PropTypes.number,
    x:  PropTypes.number,
    y:  PropTypes.number,
  }),
};

export default PlayerControls;
