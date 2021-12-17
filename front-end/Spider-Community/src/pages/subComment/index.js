import React, { Component} from 'react'
import './subComment.sass'
import $axios from '../../common/request'
import { Image, Toast, Divider} from 'antd-mobile'


class SubComment extends Component {
    constructor() {
        super()
        this.state = {
            comment:[],
            commentList:[],
            like_status:null,
            like_number:null,
            sub_comment_number:null,
            comment_like_number:{},
            comment_like_status:{},
        }
    }
    
    componentDidMount() {
        const userId = this.props.location.state.userId
        const postId = this.props.location.state.postId
        const commentId = this.props.location.state.commentId

        $axios.post('/user/load_post/loadCommentById', {
            "uid":userId,
            "pno":commentId
        }).then(res => {
            this.setState({
                comment:res.data,
                like_status:res.data.like_status,
                like_number:res.data.comment_like_number,
                sub_comment_number:res.data.sub_comment_number
            })
        })

        $axios.post('/user/load_post/loadComment', {
            "uid":userId,
            "pno":commentId
        }).then(res => {
            let obj1 = {}
            let obj2 = {}
            res.data.map(comment=>{
                obj1[comment[0].comment_id] = comment[0].like_status
                obj2[comment[0].comment_id] = comment[0].comment_like_number
            })
            this.setState({
                commentList:res.data,
                comment_like_status:obj1,
                comment_like_number:obj2, 
            }) 
        })
    }

    parent_comment_like(commentId, userId) {
        $axios.post("/user/interaction/like_comment", {
            "uid":userId,
            "pno":commentId
        }).then(res => {
            if(this.state.like_status == 1) {
                this.setState({
                    like_status:0,
                    like_number:this.state.like_number - 1
                })
            }
            else if(this.state.like_status == 0) {
                this.setState({
                    like_status:1,
                    like_number:this.state.like_number + 1
                })
            }
        })
    }

    comment(userId, postId, parentCommentId) {
        if(this.input.value != "") {
            $axios.post('/user/interaction/comment', {
                "user_id":userId,
                "post_id":postId,
                "comment_content":this.input.value,
                "parent_comment_id":parentCommentId
            }).then(res => { 
                this.input.value = null
                Toast.show({icon: 'success', content: '发送成功',})
                this.props.history.go(0)
                })
        }

    }

    comment_like(commentId, userId){
        $axios.post('/user/interaction/like_comment', {
            "uid":userId,
            "pno":commentId,
        }).then(res => {
            if(this.state.comment_like_status[commentId] == 1){
                let obj1 = {}
                let obj2 = {}
                obj1[commentId] = 0
                obj2[commentId] = this.state.comment_like_number[commentId] - 1
                let data1 = Object.assign({}, this.state.comment_like_status, obj1)
                let data2 = Object.assign({}, this.state.comment_like_number, obj2)
                this.setState({
                    comment_like_status:data1,
                    comment_like_number:data2,
                })}
            else {
                let obj1 = {}
                let obj2 = {}
                obj1[commentId] = 1
                obj2[commentId] = this.state.comment_like_number[commentId] + 1
                let data1 = Object.assign({}, this.state.comment_like_status, obj1)
                let data2 = Object.assign({}, this.state.comment_like_number, obj2)
                this.setState({
                    comment_like_status:data1,
                    comment_like_number:data2,
                })}
         })

    }

    commentLikeIf(commentId) {
        if(this.state.comment_like_status[commentId] == 1)
            return (<img onClick={this.comment_like.bind(this,commentId, this.props.location.state.userId)} src="https://img.icons8.com/dusk/17/000000/facebook-like.png"/>)
        else
            return (<img onClick={this.comment_like.bind(this,commentId, this.props.location.state.userId)} src="https://img.icons8.com/wired/17/000000/facebook-like.png"/>)
    }

    subComment(commentId, postId) {
        this.props.history.push({pathname:'/sub_comment', state:{userId:this.props.location.state.userId, commentId:commentId, postId:postId}})
        this.props.history.go(0)
    }

    reply(subCommentNumber, commentId){
        if(subCommentNumber > 1)
            return (<div className="reply" onClick={this.subComment.bind(this, commentId, this.props.location.state.postId)}>
                        查看全部{subCommentNumber}条回复
                    </div>)
        else
            return <div></div>
    }


    render() {
        if(this.state.comment == null)
           return(<div></div>)
        let parentLikeButton = null
        let backButton = null
        console.log(this.props.location.state)
        const parentCommentId = this.props.location.state.commentId
        const userId = this.props.location.state.userId
        const postId = this.props.location.state.postId

        if(this.state.like_status == 1)
            parentLikeButton = (<img onClick={this.parent_comment_like.bind(this, parentCommentId, userId)} src="https://img.icons8.com/dusk/25/000000/facebook-like.png" />)
        if(this.state.like_status == 0)
            parentLikeButton = (<img onClick={this.parent_comment_like.bind(this, parentCommentId, userId)} src="https://img.icons8.com/wired/25/000000/facebook-like.png" />)

        if(this.state.comment.parent_comment_id == this.state.comment.post_id)
            backButton = (<img src="https://img.icons8.com/fluent-systems-regular/18/000000/back.png" onClick={()=>{this.props.history.go(-1)}}/>)
        if(this.state.comment.parent_comment_id != this.state.comment.post_id) {
            backButton = (<img src="https://img.icons8.com/fluent-systems-regular/18/000000/back.png" onClick={()=>{
                this.props.history.go(-1)
                this.props.history.go(0)
            }}/>)}

        let comment = (
            <div>
                {this.state.commentList.map(oneComment=>
                    <div> 
                        <div className="oneCommentBlock">
                            <div className="one-two-img">
                                <Image src={oneComment[0].user_avatar} width={35} height={35} fit='cover' style={{ borderRadius: 25 }} onClick={()=>this.props.history.push({pathname:"/info", state:{userId: oneComment[0].user_id}})}/>
                            </div>
                            <div className="right">
                                <div className="comment-name">{oneComment[0].user_name}</div>
                                <div className="content_">{oneComment[0].comment_content}</div>
                                <div className="comment-time">
                                    <div className="one-comment-time">{oneComment[0].comment_time}</div>
                                    <div className="one-comment-like">{this.commentLikeIf(oneComment[0].comment_id)}  {this.state.comment_like_number[oneComment[0].comment_id]}</div>
                                    <div><img onClick={this.subComment.bind(this, oneComment[0].comment_id, postId)} src="https://img.icons8.com/fluency-systems-regular/17/000000/comments--v1.png"/></div>
                                </div>
                                {oneComment[1].map((twoComment, index)=>{
                                    if(index == 0)
                                        return (
                                            <div className="twoCommentBlock">
                                                <div className="one-two-img">
                                                    <Image src={twoComment.user_avatar} width={35} height={35} fit='cover' style={{ borderRadius: 25 }} onClick={()=>this.props.history.push({pathname:"/info", state:{userId: twoComment.user_id}})}/>
                                                </div>
                                                <div className="right">
                                                    <div className="comment-name">{twoComment.user_name}</div>
                                                    <div className="content_">{twoComment.comment_content}</div>
                                                    <div className="comment-name">{twoComment.comment_time}</div>
                                                    <div>{this.reply(oneComment[0].sub_comment_number, oneComment[0].comment_id)}</div>
                                                </div>
                                            </div>)
                                    else
                                        return false
                                }
                                )}
                                
                            </div>
                        </div>
                        <Divider />
                    </div>
                    )}
            </div>
        )
  
        return(
            <div className="box">
                <div className="header">
                    <div className="left">{backButton}</div>
                    <div className="comment-space">评论区</div>
                </div>
                <Divider/>
                <div className="parent-comment">
                    <div className="parent-comment-up">
                        <div className="up-avatar"><Image src={this.state.comment.user_avatar} width={40} height={40} fit='cover' style={{ borderRadius: 25 }}/></div>
                        <div className="up-right">
                            <div className="up-right-name">{this.state.comment.user_name}</div>
                            <div className="up-right-content">{this.state.comment.comment_content}</div>
                            <div className="up-right-time">{this.state.comment.comment_time}</div>
                        </div>
                    </div>
                    <div className="parent-comment-down">
                        <input className="input-comment" type="text" ref={input => this.input = input} placeholder="发条友善的评论吧"/>
                        <button className="input-button-comment" onClick={this.comment.bind(this,userId,this.props.location.state.postId,parentCommentId)}>发送</button>
                        <div>{parentLikeButton}</div>
                        <div className="parent-like-number">{this.state.like_number}</div>
                    </div>
                </div>
                <Divider/>
                <div>{comment}</div>
            </div>
        )
    }



}

export default SubComment
