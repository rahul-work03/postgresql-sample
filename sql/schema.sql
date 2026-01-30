-- Create tables
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS posts (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Seed initial users
INSERT INTO users (email, username, password_hash) VALUES
  ('test@example.com', 'testuser', 'fakehash'),
  ('alice@example.com', 'alice', 'fakehash'),
  ('bob@example.com', 'bob', 'fakehash')
ON CONFLICT (email) DO NOTHING;

-- Seed initial posts
INSERT INTO posts (user_id, title, body) 
SELECT id, 'Hello World', 'This is the first post for ' || username FROM users
ON CONFLICT DO NOTHING;

INSERT INTO posts (user_id, title, body)
SELECT id, 'Another Post', 'Sample content for ' || username FROM users
ON CONFLICT DO NOTHING;
