import React,{Fragment} from 'react'
import { BrowserRouter, Route, Switch, Redirect } from 'react-router-dom'
import Login from './pages/login'
import Home from './pages/home'
import PostContent from './pages/postContent'
import SubComment from './pages/subComment'
import Blank from './pages/blank'
import Info from './pages/info'
import InfoUpdate from './pages/infoupdate'
import Collect from './pages/collect'
import News from './pages/news'
import OtherInfo from "./pages/otherinfo"
import Post from './pages/post'

function App() {
  return (
    <div>
      <BrowserRouter>
        <Switch>
          <Route path="/login" component={Login} />
          
          <Route path="/home" component={Home} />
          <Route path="/load_post" component={PostContent} />
          <Route path="/sub_comment" component={SubComment} />
          <Route path="/blank" component={Blank} />
          <Route path="/info" component={Info} />
          <Route path="/infoupdate" component={InfoUpdate} />
          <Route path="/news" component={News} />
          <Route path="/otherinfo" component={OtherInfo} />
          <Route path="/collect" component={Collect} />
          <Route path="/post" component={Post} />
          <Route exact path="/" component={Login} />
          <Redirect to={"/login"} />
        </Switch>
      </BrowserRouter>
    </div>
  )
}

export default App