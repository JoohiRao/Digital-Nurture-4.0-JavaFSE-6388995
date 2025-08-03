import React from 'react';
import './index.css';

function App() {
  const element = "Office Space";
  const sr = "https://media.istockphoto.com/id/1464853466/photo/place-of-work.jpg?s=612x612&w=0&k=20&c=Jn0W-oZdBjtm80gWhWzropUeWoODxYrxbWIkniAbhGc="; // use your own image if needed
  const jsxatt = <img src={sr} width="25%" height="25%" alt="Office Space" />;
  const ItemName = { Name: "DBS", Rent: 50000, Address: 'Chennai' };

  let colors = [];
  if (ItemName.Rent <= 60000) {
    colors.push('textRed');
  } else {
    colors.push('textGreen');
  }

  return (
    <div style={{ padding: '20px' }}>
      <h1>{element}, at Affordable Range</h1>
      {jsxatt}
      <h1>Name: {ItemName.Name}</h1>
      <h3 className={colors.join(' ')}>Rent: Rs. {ItemName.Rent}</h3>
      <h3>Address: {ItemName.Address}</h3>
    </div>
  );
}

export default App;
