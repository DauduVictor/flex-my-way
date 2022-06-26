/// Base url for our endpoint
const BASE_URL = 'https://apiflexmyway.herokuapp.com/api/v1/';

// Endpoints regarding users
const NEW_USER_SIGNUP = BASE_URL + 'users/new';
const LOGIN = BASE_URL + 'users/login';
const FORGOT_PASSWORD = BASE_URL + 'users/forgotpassword';
const RESET_PASSWORD = BASE_URL + 'users/resetpassword';
const RESET_PASSWORD_WITH_ID = BASE_URL + 'users/resetpassword';
const UPDATE_USER_INFO = BASE_URL + 'users//update';
const DELETE_A_USER = 'id/delete';


// Endpoints regarding flex
const GET_DASHBOARD_FLEX = BASE_URL + 'flex/dashboard/';
const GET_FLEX_HISTORY = BASE_URL + '/flex/history';
const CREATE_A_FLEX = BASE_URL + 'flex/new?userid=';
const JOIN_FLEX = BASE_URL + 'flex/';
const GET_FLEX_BY_LOCATION = BASE_URL + 'flex/locate?';
const APPROVE_ATTENDEE = BASE_URL + 'flex/';
const REJECT_ATTENDEE = BASE_URL + 'flex/';

const GET_NOTIFICATION = BASE_URL + 'notification/get';