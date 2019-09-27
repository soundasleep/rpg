import React from "react";
import PropTypes from "prop-types";

class PlayerStatistics extends React.Component {
  render() {
    const { title, level } = this.props;

    return (
      <dl>
        <dt>Name</dt>
        <dd>{title}</dd>
        <dt>Level</dt>
        <dd>{level}</dd>
      </dl>
    );
  }
}

PlayerStatistics.propTypes = {
  title:   PropTypes.string,
  level:   PropTypes.number,
};

export default PlayerStatistics;
