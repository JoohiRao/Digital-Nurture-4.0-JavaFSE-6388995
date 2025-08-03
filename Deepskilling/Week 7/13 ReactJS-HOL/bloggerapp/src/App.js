import React, { useState } from 'react';
import BookDetails from './components/BookDetails';
import BlogDetails from './components/BlogDetails';
import CourseDetails from './components/CourseDetails';

import { books, blogs, courses } from './data';

function App() {
  const [view, setView] = useState('all');

  return (
    <div style={{ padding: '20px' }}>

      <div style={{ display: 'flex', gap: '10px', marginBottom: '20px' }}>
        <button onClick={() => setView('books')}>Show Books</button>
        <button onClick={() => setView('blogs')}>Show Blogs</button>
        <button onClick={() => setView('courses')}>Show Courses</button>
        <button onClick={() => setView('all')}>Show All</button>
      </div>

   
      <div style={{ display: 'flex', gap: '20px' }}>
        {view === 'books' && <BookDetails books={books} />}
        {view === 'blogs' && <BlogDetails blogs={blogs} />}
        {view === 'courses' && <CourseDetails courses={courses} />}
        {view === 'all' && (
          <>
            <BookDetails books={books} />
            <BlogDetails blogs={blogs} />
            <CourseDetails courses={courses} />
          </>
        )}
      </div>
    </div>
  );
}

export default App;
