import React, { useState, useEffect } from 'react';
import Loader from './Loader';
import DealerList from './DealerList';
import DealerMap from './DealerMap';

const App  = () => {
  const [dealers, setDealers] = useState({});
  const [loading, setLoading] = useState(true);
  const [dealerHighlightStates, setDealerHighlightStates] = useState({});

  const setInitialHighlightState = (dealers) => {
    let currentStates = {};
    dealers.forEach((dealer) => {
      currentStates[dealer.id] = false;
    });

    setDealerHighlightStates(currentStates);
  };

  const handleClick = (dealer_id) => {
    let currentStates = dealerHighlightStates;
    currentStates[dealer_id] = true;
    setDealerHighlightStates(currentStates);
  };

  useEffect(() => {
    const url = "/api/v1/dealers";
    fetch(url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error('Network response was not ok.');
      })
      .then(response => {
        setDealers(response['data']);
        setLoading(false);
        setInitialHighlightState(response['data'])
      })
      .catch(() => console.log('An error occurred while fetching the dealers'));
  }, []);

  return (
    <section className="pt-4 pt-md-11">
      <div className="container">
        <h1 className="jumbotron-heading">Dealers Portal</h1>
        {
          loading ? <Loader /> : (
            <div className="row">
              <DealerList dealers={dealers} dealerHighlightStates={dealerHighlightStates} action={handleClick} />
              <DealerMap dealers={dealers}/>
            </div>
          )
        }
      </div>
    </section>
  )
}

export default App;
