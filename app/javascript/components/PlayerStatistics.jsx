import React from "react";
import PropTypes from "prop-types";

class PlayerStatistics extends React.Component {
  render() {
    const { title, level, health, mana, world, chunk } = this.props;

    return (
      <dl>
        <dt>Name</dt>
        <dd>{title}</dd>
        <dt>Level</dt>
        <dd>{level}</dd>
        <dt>Health</dt>
        <dd>{health}</dd>
        <dt>Mana</dt>
        <dd>{mana}</dd>
        <dt>Location</dt>
        <dd>({world.x}, {world.y})</dd>
      </dl>
    );
  }
}

PlayerStatistics.propTypes = {
  title:   PropTypes.string,
  level:   PropTypes.number,
  health:  PropTypes.number,
  mana:    PropTypes.number,
  world:   PropTypes.shape({
    id: PropTypes.number,
    x:  PropTypes.number,
    y:  PropTypes.number,
  }),
  chunk:   PropTypes.shape({
    id: PropTypes.number,
    x:  PropTypes.number,
    y:  PropTypes.number,
  }),
};

export default PlayerStatistics;
