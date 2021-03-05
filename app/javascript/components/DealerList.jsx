import React, { useState, useEffect } from 'react';

const DealerList = ({ dealers, dealerHighlightStates, action }) => {
  return (
    <div className="col-lg-6 col-sm-12 border h-25 d-inline-block">
      <h3 className="jumbotron-heading">Dealers List</h3>
      <ul className="list-group">
        {dealers.map((dealer, i) => {
          let highlightClass = dealerHighlightStates[dealer.id] ? 'list-group-item-primary' : '';

          return (
            <li className={"list-group-item " + highlightClass} key={dealer.id} onClick={() => action(dealer.id)}>
                {dealer.attributes.name} -
                {dealer.attributes.account_id} -
                {dealer.attributes.pos_city} -
                {dealer.attributes.pos_zip}
            </li>
          )
        })}
      </ul>
    </div>
  )
};

export default DealerList;
