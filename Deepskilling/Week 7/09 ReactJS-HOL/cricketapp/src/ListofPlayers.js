import React from 'react';

function ListofPlayers() {
  const players = [
    { name: "Mr. Jack", score: 70 },
    { name: "Mr. Michael", score: 70 },
    { name: "Mr. John", score: 40 },
    { name: "Mr. Alvin", score: 61 },
    { name: "Mr. Ghosh", score: 50 },
    { name: "Mr. Vinit", score: 84 },
    { name: "Mr. Ramesh", score: 75 },
    { name: "Mr. Raj", score: 45 },
    { name: "Mr. Rohit", score: 80 },
    { name: "Mr. Elizabeth", score: 61 },
    { name: "Mr. Jadeja", score: 67 }
  ];

  const below70 = players.filter(item => item.score <= 70);

  return (
    <div>
      <h1>List of Players</h1>
      <ul>
        {players.map((item, index) => (
          <li key={index}>
            {item.name} <span>: {item.score}</span>
          </li>
        ))}
      </ul>

      <h1>List of Players having Scores Less than 70</h1>
      <ul>
        {below70.map((item, index) => (
          <li key={index}>{item.name}</li>
        ))}
      </ul>
    </div>
  );
}

export default ListofPlayers;
