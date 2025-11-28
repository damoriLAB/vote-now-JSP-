/**
 * 
 */
import './jquery.js'
import './removeFlashMessages.js'
import SurveyList from './components/SurveysList.js'
import './navBar.js'

const API_URL = ""

const findcomponentHSL = document.querySelector("#latestSurveys")

if(findcomponentHSL != null) new SurveyList("latestSurveys", "http://localhost:8080/vote-now/api/surveys?page=1&limit=6")