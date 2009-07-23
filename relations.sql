select a.foot_id from shoes as a, shoes as b 
where a.size = b.size 
and a.model=b.model
and a.manufacturer=b.manufacturer 
and a.foot_id != b.foot_id;