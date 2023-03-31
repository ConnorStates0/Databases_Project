<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Employee Booking</title>
  </head>
  <body>
    <h1>EMPLOYEE BOOKINGS</h1>
    <div id="search-booking" name="search-booking" class="search-booking">
      <h2>Search Booking:</h2>
      <div name="l-name-in" id="l-name-in" class="search-booking">
        <label for="cust-l-name" class="l-name-in">Customer Last Name:</label>
        <input
          type="text"
          name="cust-l-name"
          id="cust-l-name"
          class="l-name-in"
        />
      </div>
      <div name="email-in" id="email-in" class="search-booking">
        <label for="cut-email" class="email-in">Customer Email:</label>
        <input type="text" name="cust-email" id="cust-email" class="email-in" />
      </div>
      <div name="email-in" id="email-in" class="search-booking">
        <label for="cut-email" class="email-in">Customer Email:</label>
        <input type="text" name="cust-email" id="cust-email" class="email-in" />
      </div>
    </div>

    <div id="booking-out" name="booking-out" class="booking-out">
        <h2>Booking Info:</h2>
      <div id="booked-chain-out" name="booked-chain-out" class="booking-out">
        <label for="booked-chain">Chain:</label>
        <output id="booked-chain" name="booked-chain"></output>
      </div>

      <div
        id="booked-location-out"
        name="booked-location-out"
        class="booking-out"
      >
        <label for="booked-location">Location:</label>
        <output id="booked-location" name="booked-location">
      </div>

      <div id="num-rooms-out" name="num-rooms-out" class="booking-out">
        <label for="num-rooms">Number of Rooms:</label>
        <output id="num-rooms" name="num-rooms"></output>
      </div>
    </div>

    <div name="customer-payment" id="customer-payment" class="customer-payment">
        <h2>Customer Payment:</h2>
        <label for="credit-num">Credit Card Number:</label>
        <input type="text" id="credit-num" name="credit-num" class="customer-payment">
        
    </div>

    <button type="button">Approve Booking</button>
  </body>
</html>
