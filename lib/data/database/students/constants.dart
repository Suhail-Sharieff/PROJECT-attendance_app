const dbName = 'app.db';

const tableName = 'students';

//each student has roll,name,nOfClassesAttended,marks map
const rollCol = 'roll';
const nameCol = 'name';
const nOfClassesAttendedCol = 'nOfClassesAttended';

//separate tabe for students attendance tracking
const attendanceTable='attendance';
const attendanceIDcol='attendanceID';
const dateCol = 'date';
const isPresentCol = 'isPresentThatDay';
  