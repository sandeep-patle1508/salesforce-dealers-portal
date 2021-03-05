import React from 'react';

const Marker = ({ dealer }) => {
  return (
    <div className="marker"
         style={{ backgroundColor: 'blue', cursor: 'pointer'}}
         title={dealer.attributes.name}
    />
  );
};

export default Marker;
