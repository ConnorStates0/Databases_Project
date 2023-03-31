<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Room Search</title>
  </head>
  <body>
    <h1>CUSTOMER ROOM SEARCH</h1>
    <div name="search-fields" id="search-fields" class="search-fields">
      <h2>Search For A Room:</h2>
      <div id="s-date-in" name="s-date-in" class="search-fields">
        <label for="s-date">Start Date:</label>
        <input type="text" id="s-date" name="s-date" />
      </div>

      <div id="e-date-in" name="e-date-in" class="search-fields">
        <label for="e-date">End Date:</label>
        <input type="text" id="e-date" name="e-date" />
      </div>

      <div id="room-cap-in" name="room-cap-in" class="search-fields">
        <label for="room-cap">Room Capacity: </label>
        <input type="text" id="room-cap" name="room-cap" />
      </div>

      <div id="hotel-chain-in" name="hotel-chain-in" class="search-fields">
        <label for="hotel-chain">Hotel Chain:</label>
        <input type="text" id="address" name="address" />
      </div>

      <div id="num-rooms-in" name="num-rooms-in" class="search-fields">
        <label for="num-rooms">Number of Rooms:</label>
        <input type="text" id="num-rooms" name="num-rooms" />
      </div>

      <div id="price-in" name="price-in" class="search-fields">
        <label for="price">Price:</label>
        <input type="text" id="price" name="price" />
      </div>
    </div>

    <div name="outputs" id="outputs" class="outputs">
      <h2>Available Rooms:</h2>

      <div id="hotel-chain-out" name="hotel-chain-out" class="outputs">
        <label for="chain-name">Chain:</label>
        <output id="chain-name" name="chain-name"></output>
      </div>

      <div id="hotel-address-out" name="hotel-address-out" class="outputs">
        <label for="hotel-address">Address:</label>
        <output id="hotel-address" name="hotel-address"></output>
      </div>

      <div id="rating-out" name="rating-out" class="outputs">
        <label for="rating">Rating:</label>
        <output id="rating" name="rating"></output>
      </div>

      <div id="price-out" name="price-out" class="outputs">
        <label for="hotel-price">Price</label>
        <output id="hotel-price" name="hotel-price"></output>
      </div>

      <div id="contact-email-out" name="contact-email-out" class="outputs">
        <label for="num-rooms">Number of Rooms:</label>
        <output id="contact-email" name="contact-email"></output>
      </div>

      <div id="contact-phone-out" name="contact-phone-out" class="outputs">
        <label for="contact-phone">Contact Phone:</label>
        <output type="text" id="contact-phone" name="contact-phone"></output>
      </div>
    </div>

    <button id="confirm-button" name="confim-button">Book Now</button>
  </body>
</html>
