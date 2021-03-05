import React, { useState, useEffect } from 'react';
import Loader from './Loader';

const App  = () => {
  const [dealers, setDealers] = useState({});
  const [loading, setLoading] = useState(true);

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
        setDealers(response);
        setLoading(false);
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
              <div className="col-6 border">
                List
              </div>

              <div className="col-6 border">
                Map
              </div>
            </div>
          )
        }
      </div>
    </section>
  )
}

export default App;
