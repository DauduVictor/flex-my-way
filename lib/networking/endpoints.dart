/// Base url for our endpoint
const BASE_URL = 'https://apiflexmyway.herokuapp.com/api/v1/';

// Endpoints regarding users
const NEW_USER_SIGNUP = 'users/new';
const LOGIN = BASE_URL + 'users/login';
const FORGOT_PASSWORD = 'users/forgotpassword';
const RESET_PASSWORD = 'users/resetpassword';
const UPDATE_USER_INFO = 'id/update';
const DELETE_A_USER = 'id/delete';


// Endpoints regarding flex
const CREATE_A_FLEX = 'flex/new?userid=';