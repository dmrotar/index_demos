
CREATE TABLE people (
  id serial PRIMARY KEY,
  last_name text NOT NULL,
  first_name text NOT NULL,
  phone text NOT NULL,
  age integer NOT NULL,
  favorite_color text NOT NULL,
  visited_countries text[] NOT NULL
);

-- PGPASSWORD=postgres psql -h localhost -p 10100 -d index_demos -U postgres --command "\COPY people FROM '/Users/dan/code/fireball/services/main_large.csv' WITH (format csv)"



explain analyze
select * from people where id = 2500;



explain analyze
select * from people where phone = '2-518-644-5719';

create index idx_people_phone on people (phone);
drop index idx_people_phone;



explain analyze
select * from people where first_name = 'Annie' and last_name = 'Stevens' and age = 59;

create index idx_people_last_name on people (last_name);
drop index idx_people_last_name;

create index idx_people_first_name on people (first_name);
drop index idx_people_first_name;

create index idx_people_last_name_and_first_name on people (last_name, first_name);
drop index idx_people_last_name_and_first_name;

create index idx_people_last_name_first_name_age on people (last_name, first_name, age);
drop index idx_people_last_name_first_name_age;



explain analyze
select * from people where first_name = 'Michael' order by phone limit 1000;

create index idx_people_first_name on people (first_name);
drop index idx_people_first_name;

create index idx_people_first_name_phone on people (first_name, phone);
drop index idx_people_first_name_phone;

create index idx_people_phone_first_name on people (phone, first_name);
drop index idx_people_phone_first_name;



explain analyze
select * from people where age = 25 and favorite_color = 'Blue' limit 100;

explain analyze
select * from people where age < 25 and favorite_color = 'Blue' limit 100;

create index idx_people_age_favorite_color on people (age, favorite_color);
drop index idx_people_age_favorite_color;

create index idx_people_favorite_color_age on people (favorite_color, age);
drop index idx_people_favorite_color_age;



explain analyze
select * from people where favorite_color = 'Blue' and visited_countries @> '{Greenland}' limit 100;

create index idx_people_favorite_color on people (favorite_color);
drop index idx_people_favorite_color;

create index idx_people_visited_countries on people using gin (visited_countries);
drop index idx_people_visited_countries;



explain analyze
select * from people where right(last_name, 1) = 'z' order by right(phone, 8) limit 10;

create index idx_people_phone on people (phone);
drop index idx_people_phone;

create index idx_people_last_name on people (last_name);
drop index idx_people_last_name;

create index idx_people_right_last_name_right_phone on people (right(last_name, 1), right(phone, 8));
drop index idx_people_right_last_name_right_phone;


