PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    follower_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_id INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    liker_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (liker_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Tim', 'Harding'),
    ('Ellie', 'Baer'),
    ('Monica', 'Kim'),
    ('Lauren', 'Chanen'),
    ('Doug', 'Sigelbaum'),
    ('Elias', 'Horat'),
    ('Yasar', 'Mohebi'),
    ('Michael', 'Mann');

INSERT INTO
    questions (title, body, user_id)
VALUES
    ('Tim Question', 'TIM TIM TIM', (SELECT id FROM users WHERE fname = 'Tim')),
    ('Ellie Question', 'ELLIE ELLIE ELLIE', (SELECT id FROM users WHERE fname = 'Ellie')),
    ('Monica Question', 'MONICA MONICA MONICA', (SELECT id FROM users WHERE fname = 'Monica')),
    ('Lauren Question', 'LAUREN LAUREN LAUREN', (SELECT id FROM users WHERE fname = 'Lauren')),
    ('Doug Question', 'DOUG DOUG DOUG', (SELECT id FROM users WHERE fname = 'Doug')),
    ('Elias Question', 'ELIAS ELIAS ELIAS', (SELECT id FROM users WHERE fname = 'Elias')),
    ('Yasar Question', 'YASAR YASAR YASAR', (SELECT id FROM users WHERE fname = 'Yasar')),
    ('Michael Question', 'MICHAEL MICHAEL MICHAEL', (SELECT id FROM users WHERE fname = 'Michael'));

INSERT INTO
    question_follows (question_id, follower_id)
VALUES
    ((SELECT id FROM questions WHERE title LIKE 'Ellie %'), (SELECT id FROM users WHERE fname = 'Tim')),
    ((SELECT id FROM questions WHERE title LIKE 'Monica %'), (SELECT id FROM users WHERE fname = 'Ellie')),
    ((SELECT id FROM questions WHERE title LIKE 'Lauren %'), (SELECT id FROM users WHERE fname = 'Monica')),
    ((SELECT id FROM questions WHERE title LIKE 'Doug %'), (SELECT id FROM users WHERE fname = 'Lauren')),
    ((SELECT id FROM questions WHERE title LIKE 'Elias %'), (SELECT id FROM users WHERE fname = 'Doug')),
    ((SELECT id FROM questions WHERE title LIKE 'Yasar %'), (SELECT id FROM users WHERE fname = 'Elias')),
    ((SELECT id FROM questions WHERE title LIKE 'Michael %'), (SELECT id FROM users WHERE fname = 'Yasar')),
    ((SELECT id FROM questions WHERE title LIKE 'Tim %'), (SELECT id FROM users WHERE fname = 'Michael'));

INSERT INTO
    replies (question_id, parent_id, user_id, body)
VALUES
    ((SELECT id FROM questions WHERE title LIKE 'Tim %'), NULL, (SELECT id FROM users WHERE fname = 'Ellie'), ('reply from Ellie')),
    ((SELECT id FROM questions WHERE title LIKE 'Ellie %'), NULL, (SELECT id FROM users WHERE fname = 'Monica'), ('reply from Monica')),
    ((SELECT id FROM questions WHERE title LIKE 'Monica %'), NULL, (SELECT id FROM users WHERE fname = 'Lauren'), ('reply from Lauren')),
    ((SELECT id FROM questions WHERE title LIKE 'Lauren %'), NULL, (SELECT id FROM users WHERE fname = 'Doug'), ('reply from Doug')),
    ((SELECT id FROM questions WHERE title LIKE 'Doug %'), NULL, (SELECT id FROM users WHERE fname = 'Elias'), ('reply from Elias'));

INSERT INTO
    replies (question_id, parent_id, user_id, body)
VALUES
    ((SELECT id FROM questions WHERE title LIKE 'Doug %'), (SELECT id FROM replies WHERE body = 'reply from Elias'), (SELECT id FROM users WHERE fname = 'Yasar'), ('reply from Yasar')),
    ((SELECT id FROM questions WHERE title LIKE 'Lauren %'), (SELECT id FROM replies WHERE body = 'reply from Doug'), (SELECT id FROM users WHERE fname = 'Michael'), ('reply from Michael')),
    ((SELECT id FROM questions WHERE title LIKE 'Tim %'), (SELECT id FROM replies WHERE body = 'reply from Ellie'), (SELECT id FROM users WHERE fname = 'Tim'), ('reply from Tim'));

INSERT INTO
    question_likes (liker_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Tim'), (SELECT id from questions WHERE title LIKE 'Tim %')),
    ((SELECT id FROM users WHERE fname = 'Ellie'), (SELECT id from questions WHERE title LIKE 'Tim %')),
    ((SELECT id FROM users WHERE fname = 'Monica'), (SELECT id from questions WHERE title LIKE 'Tim %')),
    ((SELECT id FROM users WHERE fname = 'Lauren'), (SELECT id from questions WHERE title LIKE 'Tim %')),
    ((SELECT id FROM users WHERE fname = 'Doug'), (SELECT id from questions WHERE title LIKE 'Doug %')),
    ((SELECT id FROM users WHERE fname = 'Elias'), (SELECT id from questions WHERE title LIKE 'Doug %')),
    ((SELECT id FROM users WHERE fname = 'Yasar'), (SELECT id from questions WHERE title LIKE 'Doug %')),
    ((SELECT id FROM users WHERE fname = 'Michael'), (SELECT id from questions WHERE title LIKE 'Doug %'));