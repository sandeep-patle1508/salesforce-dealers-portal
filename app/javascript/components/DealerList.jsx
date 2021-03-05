import React from 'react';

const DealerList = ({ dealers }) => {
  return (
    <div className="col-lg-6 col-sm-12 border h-25 d-inline-block">
      <h3 className="jumbotron-heading">Dealers List</h3>
      <div className="list-group">
        {dealers.map((dealer, i) => {
          return (
            <div>
              <a href="#" className="list-group-item list-group-item-action">
                {dealer.attributes.name} -
                {dealer.attributes.account_id} -
                {dealer.attributes.pos_city} -
                {dealer.attributes.pos_zip} 
              </a>
            </div>
          )
        })}
      </div>
    </div>
  )
};

export default DealerList;
