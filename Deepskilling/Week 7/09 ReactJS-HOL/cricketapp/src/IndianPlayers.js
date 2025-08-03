import React from 'react';

const T20Players = ['First Player', 'Second Player', 'Third Player'];
const RanjiPlayers = ['Fourth Player', 'Fifth Player', 'Sixth Player'];
const IndianPlayersList = [...T20Players, ...RanjiPlayers];

function OddPlayers({ players }) {
  const [first, , third, , fifth] = players;

  return (
    <div>
      <h3>Odd Players</h3>
      <ul>
        <li>First: {first}</li>
        <li>Third: {third}</li>
        <li>Fifth: {fifth}</li>
      </ul>
    </div>
  );
}

function EvenPlayers({ players }) {
  const [, second, , fourth, , sixth] = players;

  return (
    <div>
      <h3>Even Players</h3>
      <ul>
        <li>Second: {second}</li>
        <li>Fourth: {fourth}</li>
        <li>Sixth: {sixth}</li>
      </ul>
    </div>
  );
}

function IndianPlayers() {
  return (
    <div>
      <h2>Indian Team</h2>
      <OddPlayers players={IndianPlayersList} />
      <EvenPlayers players={IndianPlayersList} />
      <h3>List of Indian Players Merged</h3>
      <ul>
        {IndianPlayersList.map((p, index) => (
          <li key={index}>{p}</li>
        ))}
      </ul>
    </div>
  );
}

export default IndianPlayers;
