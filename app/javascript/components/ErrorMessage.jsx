import React from "react";
import PropTypes from "prop-types";

class ErrorMessage extends React.Component {
  render() {
    const { message, url } = this.props;

    return (
      <div className="error-message">
        <p>
          {message}
        </p>
        {url ? <p><small>{url}</small></p> : ""}
      </div>
    );
  }
}

ErrorMessage.propTypes = {
  message: PropTypes.string.isRequired,
  url:     PropTypes.string,
};

export default ErrorMessage;
