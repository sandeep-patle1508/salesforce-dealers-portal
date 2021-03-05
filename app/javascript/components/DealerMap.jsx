import React, { useState } from 'react';
import GoogleMapReact from 'google-map-react';
import Marker from './Marker';

const MarkerComponent = ({ text }) => <div>{text}</div>;

const DealerMap = ({ dealers }) => {
  const [center, setCenter] = useState({lat: 51.1657, lng: 10.4515 });
  const [zoom, setZoom] = useState(6);

  let dealersWithLoc = dealers.filter(function(dealer) {
    let lat = dealer.attributes.location_latitude;
    let long = dealer.attributes.location_longitude;

    if(lat !== null && lat !== '' && long !== null && long !== ''){
      return true;
    }

    return false;
  });

    return (
    <div className="col-lg-6 col-sm-12 border h-25 d-inline-block">
      <div style={{ height: '50vh', width: '100%' }}>
        <GoogleMapReact
          bootstrapURLKeys={{ key: 'AIzaSyABp7WokOVHK6NFGkkeYHlnMPUrXPP2nU0' }}
          defaultCenter={center}
          defaultZoom={zoom}
        >
          {dealers.map((dealer, i) => {
            return (
              <Marker
                lat={dealer.attributes.location_latitude}
                lng={dealer.attributes.location_longitude}
                dealer={dealer}
                key={dealer.id}
              />
            )
          })}
        </GoogleMapReact>
      </div>
    </div>
  );
};

export default DealerMap;
