import React from 'react';

const CourseDetails = ({ courses }) => (
  <div className="mystyle1">
    <h1>Course Details</h1>
    <ul>
      {courses.map(course => (
        <div key={course.id}>
          <h3>{course.name}</h3>
          <h4>{course.date}</h4>
        </div>
      ))}
    </ul>
  </div>
);

export default CourseDetails;
