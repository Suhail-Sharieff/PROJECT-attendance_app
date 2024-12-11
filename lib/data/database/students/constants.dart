const dbName = 'app.db';

const studentsTable = 'studentsTable';

//each student has roll,name,nOfClassesAttended,marks map
const rollCol = 'roll';
const nameCol = 'name';
const nOfClassesAttendedCol = 'nOfClassesAttended';

//separate tabe for students attendance tracking
const attendanceTable='attendanceTable';
const attendanceIDcol='attendanceID';
const dateCol = 'date';
const isPresentCol = 'isPresentThatDay';


//separate table for that class
const classesTable='classesTable';
const classIDcol='class_ID';
const classNameCol='class_name';

//for schedules:
const scheduleTable='scheduleTable';
const scheduleIDcol='schedule_ID';
const scheduledClassCol='scheduled_Class';
const scheduledFromTimeCol='scheduled_from_time';
const scheduledToTimeCol='scheduled_to_time';