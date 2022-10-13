/// Base url for our endpoint
const BASE_URL = 'https://apiflexmyway.herokuapp.com/api/v1/';
// const BASE_URL = 'https://lime-perfect-cow.cyclic.app/api/v1/';

// Endpoints regarding users
const NEW_USER_SIGNUP = BASE_URL + 'users/new';
const LOGIN = BASE_URL + 'users/login';
const FORGOT_PASSWORD = BASE_URL + 'users/password/forgot';
const RESET_PASSWORD = BASE_URL + 'users/password/reset';
const EDIT_PASSWORD = BASE_URL + 'users/password/edit';
const UPDATE_USER_INFO = BASE_URL + 'users/update';
const UPGRADE_USER = BASE_URL + 'users/upgrade';
const DELETE_A_USER = 'id/delete';


// Endpoints regarding flex
const GET_DASHBOARD_FLEX = BASE_URL + 'flex/dashboard/';
const GET_FLEX_HISTORY = BASE_URL + 'flex/history';
const CREATE_A_FLEX = BASE_URL + 'flex/new';
const JOIN_FLEX = BASE_URL + 'flex/';
const GET_FLEX_BY_LOCATION = BASE_URL + 'flex/locate?';
const APPROVE_ATTENDEE = BASE_URL + 'flex/';
const REJECT_ATTENDEE = BASE_URL + 'flex/';
const GET_FLEXERY = BASE_URL + 'flexery/get';
const ADD_FLEXERY = BASE_URL + 'flexery/new';
const GET_FLEX_INVITEES = BASE_URL + 'flex/invitees';
const GET_FLEX_DETAILS = BASE_URL + 'flex/';
const UPDATE_A_FLEX = BASE_URL + 'flex/';

const GET_NOTIFICATION = BASE_URL + 'notification/get';
const DELETE_NOTIFICATION = BASE_URL + 'notification/';

const GOOGLE_PLACE_API = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';