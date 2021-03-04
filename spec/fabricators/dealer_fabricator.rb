# frozen_string_literal: true

Fabricator(:dealer) do
  account_id '1111'
  name                  'Test Account 1'
  pos_street            'Mitte'
  pos_city              'Berlin'
  pos_zip               '10999'
  pos_country           'Germany'
  pos_state             'Berlin'
  pos_phone             '123456789'
  location_latitude     52.5373
  location_longitude    13.3603
end
