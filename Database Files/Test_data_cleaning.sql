-- Calculate the trip_durations
SELECT trip_duration,start_timestamp, stop_timestamp,
(((HOUR(stop_timestamp) * 60 * 60) + (MINUTE(stop_timestamp) * 60) + SECOND (stop_timestamp)) -
 ((HOUR(start_timestamp) * 60 * 60) + (MINUTE(start_timestamp) * 60) + SECOND(start_timestamp))) As trip_duration_sec,
(((HOUR(stop_timestamp) * 60 ) + (MINUTE(stop_timestamp))) - ((HOUR(start_timestamp) * 60) + (MINUTE(start_timestamp)))) As trip_duration_min,
(HOUR(stop_timestamp) - HOUR(start_timestamp)) As trip_duration_hour
from rides;

  -- trip_duration_sec column
  alter table rides 
  add column trip_duration_sec int not null default 0;
  
  -- mins column
   alter table rides
  add column trip_duration_min int not null default 0;

-- add hour column
   alter table rides 
  add column trip_duration_hour int not null default 0;
    
    -- update the trip_duration column with the calculation for the duration
  update rides
  set trip_duration_sec = (((HOUR(stop_timestamp) * 60 * 60) + (MINUTE(stop_timestamp) * 60) + SECOND (stop_timestamp)) 
  - ((HOUR(start_timestamp) * 60 * 60) + (MINUTE(start_timestamp) * 60) + SECOND(start_timestamp)))
  where trip_duration_sec = 0;
  
  -- update the trip_duration column with the calculation for the duration
  update rides
  set trip_duration_min = (((HOUR(stop_timestamp) * 60 ) + (MINUTE(stop_timestamp))) - ((HOUR(start_timestamp) * 60) + (MINUTE(start_timestamp))))
  where trip_duration_min = 0;

    -- update the trip_duration column with the calculation for the duration
  update rides
  set trip_duration_hour = (HOUR(stop_timestamp) - HOUR(start_timestamp))
  where trip_duration_hour = 0;
  
  
  
  -- confirm that the column was generated and populated
  select * from full_data;

  
-- compare both trip duration columns
select trip_duration,tripduration from full_data;
  
-- check for trip durations with negative values (92 rows returned for the testing data)
select bikeid, usertype,start_station_id,end_station_id,trip_duration,tripduration from full_data where trip_duration < 0;

-- check the number of trips per start and end station with negative values
select start_station_id, count(start_station_id) c_start, end_station_id, count(end_station_id) c_end from full_data group by start_station_id,
end_station_id;
-- delete trips with negative values
delete from full_data where trip_duration < 0;
  
-- drop the tripduration column with the wrong values
alter table full_data
drop column tripduration;

-- Count the trips to and from each station
SELECT start_ride.trip_id trip_id,start_station_id, start_station_name, num_of_trips_start, end_station_id, end_station_name, num_of_trips_end FROM
( -- Total rides from the start stations
SELECT ROW_NUMBER() OVER() trip_id, start_station_id, start_station_name, count(start_station_id) num_of_trips_start 
FROM full_data GROUP BY start_station_id) start_ride
JOIN
( -- Total rides to the end stations
SELECT ROW_NUMBER() OVER() trip_id, end_station_id, end_station_name, count(end_station_id) num_of_trips_end 
FROM full_data GROUP BY end_station_id order by 4 desc) end_ride
USING(trip_id);




select start_station_name,start_station_id,end_station_name,end_station_id from full_data where start_station_id= 38 and end_station_id = 72 ;
select start_station_id,start_station_name, count(start_station_id) c_start, row_number() over() sn from full_data group by start_station_id,end_station_id;
select end_station_id,end_station_name, count(end_station_id) c_end, row_number() over() en from full_data group by end_station_id,start_station_id;
select start_station_name,start_station_id,end_station_name,end_station_id from full_data;

select row_number() over(order by start_station_id) numb,start_station_id,start_station_name,end_station_name,end_station_id  from full_data;
select start_station_name,start_station_id,end_station_name,end_station_id from full_data order by start_station_id asc;



select start_station_id, count(start_station_id) c_start from full_data group by start_station_id;
select end_station_id, count(end_station_id) c_end from full_data group by end_station_id;



select start_station_id, count(start_station_id) c_start, row_number() over() sn from full_data group by start_station_id,end_station_id;
select end_station_id, count(end_station_id) c_end, row_number() over() en from full_data group by end_station_id,start_station_id;
select start_station_name,start_station_id,end_station_name,end_station_id from full_data;


select start_station_id,start_station_name, count(start_station_id) num_of_trips_start,
end_station_id,end_station_name, count(end_station_id) num_of_trips_end from full_data group by start_station_id,end_station_id
order by 3 desc;

select start_station_name,start_station_id,end_station_name,end_station_id from full_data where start_station_id= 9 and end_station_id = 41 ;