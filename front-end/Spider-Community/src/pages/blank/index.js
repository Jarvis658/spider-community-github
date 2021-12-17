import React, { Component, Fragment} from 'react'

class Blank extends Component {

    componentDidMount(){
        this.props.history.push({pathname:'/sub_comment', state:{userId:this.props.location.state.userId, commentId:this.props.location.state.commentId, postId:this.props.location.state.postId}})
    }

    render(){
        return(<div></div>)
    }
}

export default Blank