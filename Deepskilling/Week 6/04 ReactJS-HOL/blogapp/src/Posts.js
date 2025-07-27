// src/Posts.js
import React, { Component } from "react";

class Posts extends Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: [],
    };
  }

  // Fetch API data
  loadPosts() {
    fetch("https://jsonplaceholder.typicode.com/posts")
      .then((response) => response.json())
      .then((data) => {
        this.setState({ posts: data });
      })
      .catch((error) => {
        alert("Error fetching posts: " + error);
      });
  }

  // Called after component mounts
  componentDidMount() {
    this.loadPosts();
  }

  // Handle errors
  componentDidCatch(error, info) {
    alert("An error occurred: " + error);
    console.error("Error:", error, info);
  }

  render() {
    return (
      <div>
        <h1>Blog Posts</h1>
        {this.state.posts.map((post) => (
          <div key={post.id}>
            <h2>{post.title}</h2>
            <p>{post.body}</p>
          </div>
        ))}
      </div>
    );
  }
}

export default Posts;
