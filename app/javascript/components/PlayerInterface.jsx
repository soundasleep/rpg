import React from "react";
import PropTypes from "prop-types";

import ErrorMessage from "./ErrorMessage";
import Loading from "./Loading";
import PlayerStatistics from "./PlayerStatistics";

class PlayerInterface extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      error:    null,
      errorUrl: null,
      isLoaded: false,
      player:   null,
    };
  }

  componentDidMount() {
    const url = `${this.props.api_root}/players/${this.props.id}.json`;

    fetch(url)
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isLoaded: true,
            player:   result,
          });
        },
        // Note: it's important to handle errors here
        // instead of a catch() block so that we don't swallow
        // exceptions from actual bugs in components.
        (error) => {
          this.setState({
            isLoaded: true,
            error,
            errorUrl: url,
          });
        }
      )
  }

  render() {
    const { error, errorUrl, isLoaded, player } = this.state;

    if (error) {
      return <ErrorMessage message={error} url={errorUrl} />;
    } else if (!isLoaded) {
      return <Loading />;
    } else {
      return <div className="player-interface">
        <div className="player-statistics">
          <PlayerStatistics {...player} />
        </div>
        <div className="player-view">
          player-view
        </div>
      </div>;
    }
  }
}

PlayerInterface.propTypes = {
  id:       PropTypes.number.isRequired,
  api_root: PropTypes.string.isRequired,
};

export default PlayerInterface;
