import React, { Component, Fragment} from 'react'
import './postContent.sass'
import Header from '../../components/header'
import $axios from '../../common/request'
import { Sticky } from 'react-vant'
import { Image, Toast, Button, Divider, Popup, Dialog} from 'antd-mobile'



class PostContent extends Component {
    constructor(){
        super()
        this.state = {
            post:null,
            commentList:[],
            follow_status:null,
            like_status:null,
            collect_status:null,
            collect_number:null,
            visible_collect_group:false,
            collectList:[],
            post_like_number:null,
            post_comment_number:null,
            collect_group_status:{},
            collect_group_post_number:{},
            comment_like_number:{},
            comment_like_status:{},
        }
    }


    componentDidMount() {
        const userId = this.props.location.state.userId
        const postId = this.props.location.state.postId
        $axios.post('/user/load_post/loadPost', {
            "uid":userId,
            "pno":postId
        }).then(res => {
            this.setState({
                post:res.data,
                follow_status:res.data.follow_status,
                like_status:res.data.like_status,
                collect_status:res.data.collect_status,
                post_like_number:res.data.post_like_number,
                collect_number:res.data.collect_number,
                post_comment_number:res.data.comment_number,
            })
        })

        $axios.post('/user/load_post/loadComment', {
            "uid":userId,
            "pno":postId
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

        $axios.post('/user/interaction/loadCollectGroups', {
            "uid":userId,
            "pno":postId
        }).then(res => {
            let obj1 = {}
            let obj2 = {}
            res.data.map(collect=>{
                obj1[collect.collect_group_id] = collect.collect_status
                obj2[collect.collect_group_id] = collect.post_number
            })
            this.setState({
                collectList:res.data,
                collect_group_status:obj1,
                collect_group_post_number:obj2, 
            })
        })
    }

    attention(myUid, otherUid) {
        $axios.post('/user/interaction/attention', {
            "myUid":myUid,
            "otherUid":otherUid
        }).then(res => {
                if(this.state.follow_status == 1) {
                    this.setState({
                        follow_status:0
                    })
                }
                else if(this.state.follow_status == 0) {
                    this.setState({
                        follow_status:1
                    })
                }   
            })
    }

    post_like(userId, postId) {
        $axios.post('/user/interaction/like_post', {
            "uid":userId,
            "pno":postId
        }).then(res => {
                if(this.state.like_status == 1) {
                    this.setState({
                        like_status:0,
                        post_like_number:this.state.post_like_number-1
                    })
                }
                else if(this.state.like_status == 0) {
                    this.setState({
                        like_status:1,
                        post_like_number:this.state.post_like_number+1
                    })
                }   
            })
    }

    collect(collectStatus,collectGroupId,userId,postId) {
        $axios.post('/user/interaction/collect', {
            "uid":userId,
            "pno":postId,
            "collectGroupId":collectGroupId
        }).then(res => { 
            if(collectStatus == 1){
                let obj1 = {}
                let obj2 = {}
                obj1[collectGroupId] = 0
                obj2[collectGroupId] = this.state.collect_group_post_number[collectGroupId] - 1
                let data1 = Object.assign({}, this.state.collect_group_status, obj1)
                let data2 = Object.assign({}, this.state.collect_group_post_number, obj2)
                this.setState({
                    collect_number:this.state.collect_number-1,
                    collect_group_status:data1,
                    collect_group_post_number:data2,
                })}
            else {
                let obj1 = {}
                let obj2 = {}
                obj1[collectGroupId] = 1
                obj2[collectGroupId] = this.state.collect_group_post_number[collectGroupId] + 1
                let data1 = Object.assign({}, this.state.collect_group_status, obj1)
                let data2 = Object.assign({}, this.state.collect_group_post_number, obj2)
                this.setState({
                    collect_number:this.state.collect_number+1,
                    collect_group_status:data1,
                    collect_group_post_number:data2,
                })
            }
            })
    }

    comment(userId,postId){
        if(this.input.value != "") {
            $axios.post('/user/interaction/comment', {
                "user_id":userId,
                "post_id":postId,
                "comment_content":this.input.value,
                "parent_comment_id":postId
            }).then(res => { 
                this.input.value = null
                Toast.show({icon: 'success', content: '发送成功',})
                this.setState({
                    post_comment_number:this.state.post_comment_number + 1
                })
                this.props.history.go(0)
                })
        }
	}

    collectButtonIf(collect_status,userId,postId,collectGroupId){
        if(this.state.collect_group_status[collectGroupId] == 1)
            return <Button className="input-button" block shape='rounded' onClick={this.collect.bind(this,collect_status,collectGroupId,userId,postId)}>已收藏</Button>
        else
            return <Button color='primary' className="input-button" block shape='rounded' onClick={this.collect.bind(this,collect_status,collectGroupId,userId,postId)}>收藏</Button>
    }

    reply(subCommentNumber, commentId){
        if(subCommentNumber > 1)
            return (<div className="reply" onClick={this.subComment.bind(this, commentId, this.props.location.state.postId)}>
                        查看全部{subCommentNumber}条回复
                    </div>)
        else
            return <div></div>
    }

    subComment(commentId, postId) {
        this.props.history.push({pathname:'/sub_comment', state:{userId:this.props.location.state.userId, commentId:commentId, postId:postId}})
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

    deleteButton(hostId, commentId) {
        if(hostId == this.props.location.state.userId)
            return <img onClick={this.deleteComment.bind(this,this.props.location.state.postId, commentId)} src="https://img.icons8.com/ios/17/000000/delete--v1.png"/>
        else
            return
    }

    deleteComment(postId, commentId) {
        Dialog.confirm({
            content: '是否删除该条评论',
            onConfirm:() => {
                $axios.post("/user/interaction/delete_comment",{
                    post_id:postId,
                    comment_id:commentId
                })
              Toast.show({
                icon: 'success',
                content: '删除成功',
                position: 'center',
              })
              this.props.history.go(0)

            },
          })
    }

    render() {
        const userId = this.props.location.state.userId
        const postId = this.props.location.state.postId
        // const content = 'content'
        
        if(this.state.post == null)
            return(<div></div>)
        const content1 = this.state.post.post_content
        // console.log(content)
        // console.log(content1)

        let followButton = null;
        let postLikeButton = null
        let collectButton = null

        if(this.state.follow_status == 1)
            followButton = (<Button size='small' shape='rounded' onClick={this.attention.bind(this, userId, this.state.post.user_id)}>已关注</Button>)
        if(this.state.follow_status == 0)
            followButton = (<Button size='small' color='primary' shape='rounded' onClick={this.attention.bind(this, userId, this.state.post.user_id)}>关注</Button>)
        
        if(this.state.collect_number > 0)
            collectButton = (<img src="https://img.icons8.com/office/25/000000/add-to-favorites.png" onClick={()=>{this.setState({visible_collect_group:true})}}/>)
        if(this.state.collect_number == 0)
            collectButton = (<img src="https://img.icons8.com/ios/25/000000/add-to-favorites--v1.png" onClick={()=>{this.setState({visible_collect_group:true})}}/>)

        if(this.state.like_status == 0)
            postLikeButton = (<img src="https://img.icons8.com/wired/25/000000/facebook-like.png" onClick={this.post_like.bind(this, userId, this.state.post.post_id)}/>)
        if(this.state.like_status == 1)
            postLikeButton = (<img src="https://img.icons8.com/dusk/25/000000/facebook-like.png" onClick={this.post_like.bind(this, userId, this.state.post.post_id)}/>)

        let comment = (
            <div>
                {this.state.commentList.map(oneComment=>
                    <div> 
                        <div className="oneCommentBlock">
                            <div className="one-two-img">
                                <Image src={oneComment[0].user_avatar} width={35} height={35} fit='cover' style={{ borderRadius: 25 }}/>
                            </div>
                            <div className="right">
                                <div className="comment-name">{oneComment[0].user_name}</div>
                                <div className="content_">{oneComment[0].comment_content}</div>
                                <div className="comment-time">
                                    <div className="one-comment-time">{oneComment[0].comment_time}</div>
                                    <div className="one-comment-like">{this.commentLikeIf(oneComment[0].comment_id)}  {this.state.comment_like_number[oneComment[0].comment_id]}</div>
                                    <div className="comment-comment"><img onClick={this.subComment.bind(this, oneComment[0].comment_id, postId)} src="https://img.icons8.com/fluency-systems-regular/17/000000/comments--v1.png"/> {oneComment[0].sub_comment_number}</div>
                                    <div className="comment-delete-button">{this.deleteButton(oneComment[0].user_id, oneComment[0].comment_id)}</div>
                                </div>
                                {oneComment[1].map((twoComment, index)=>{
                                    if(index == 0)
                                        return (
                                            <div className="twoCommentBlock">
                                                <div className="one-two-img">
                                                    <Image src="https://images.unsplash.com/photo-1567945716310-4745a6b7844b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=60" width={35} height={35} fit='cover' style={{ borderRadius: 25 }}/>
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

        let collectList = (
            <div>
                {this.state.collectList.map(collect=>
                <div>
                    <p></p>
                    <p></p>
                    <div className="collect-one">
                        <div className="collect-two">
                            <div className="font-one">{collect.collect_group_name}</div> 
                            <div className="font-two">{this.state.collect_group_post_number[collect.collect_group_id]}个内容</div>   
                        </div>  
                        <div>{this.collectButtonIf(this.state.collect_group_status[collect.collect_group_id], userId, postId, collect.collect_group_id)}</div>    
                    </div>
                    <Divider />
                </div>
                )}
            </div>
        )
        
            
            return (
            <div className="all">
                <Popup visible={this.state.visible_collect_group}
                    onMaskClick={() => {this.setState({visible_collect_group:false})}}
                    bodyStyle={{borderTopLeftRadius: '8px',borderTopRightRadius: '8px',minHeight: '50vh',
                    }}>
                    {collectList}
                </Popup>

                <div>
                    <div className="header">
                        <div><img src="https://img.icons8.com/ios/35/000000/left.png" onClick={()=>this.props.history.go(-1)}/></div>
                        <div className="user-avatar" onClick={() => {}}>
                            <Image src={this.state.post.user_avatar} width={44} height={44} fit='cover' style={{ borderRadius: 25 }}/></div>
                        <div className="user-name">{this.state.post.user_name}</div>
                        <div className="follow-button">{followButton}</div>
                    </div>
                    <Divider />
                </div>
                <div className="content">
                    <span dangerouslySetInnerHTML={{__html: this.state.post.post_content}} className="richText"></span>
                    <Divider />
                    <div className="interaction">
                        <input className="input-comment" type="text" ref={input => this.input = input} placeholder="发条友善的评论吧"/>
                        <Button className="input-button" onClick={this.comment.bind(this,userId,postId)} block shape='rounded' color='primary'>发送</Button>
                        <div className="post-like">
                            {postLikeButton}
                            <label className="interaction-number"> {this.state.post_like_number}</label>
                        </div>
                        <div className="post-collect">
                            {collectButton}
                            <label className="interaction-number"> {this.state.collect_number}</label>
                        </div>
                    </div>
                    <div className="comment-number">共{this.state.post_comment_number}条评论</div>
                    <Divider />
                    <div>{comment}</div>
                </div>
                <div>

                </div>
                
            </div>
        )
    }


}

export default PostContent