import React, { Component } from 'react'
import './post.sass'
import $axios from '../../common/request'
import Quill from 'quill'
import 'quill/dist/quill.snow.css'
import { ImageDrop } from 'quill-image-drop-module';
import quillEmoji from 'quill-emoji';
import "quill-emoji/dist/quill-emoji.css"; //这个不引入的话会出现emoji框一直在输入框下面的情况
//import ImageResize  from 'quill-image-resize-module';
import { Button, Popup, Input, Toast } from 'antd-mobile'
import { LeftCircleOutlined, PlusCircleOutlined } from '@ant-design/icons'
import { Upload } from 'antd'

const { EmojiBlot} = quillEmoji;
class Post extends Component {
    constructor(props) {
        super(props);
        this.state = {
            post_id: null,
            user_id: null,
            content: null,
            uploadBoxVisible: false,
            currentTitle: '',
            currentCover: null,
            currentCoverUrl: '',
            uploadToken: '',
            fileKey: '',
            visible: false,
            labelVisible: false,
            submitErrorVisible: false,
            loadingIcon: false,
            labelArray: [],
            editorOnload: 0,
            rewrite: 0
        };
        this.editor = null;
    }

    componentWillMount() { }

    componentDidMount() {
        let postIdInProps = null;
        let userIdInProps = null;
        if(typeof(this.props.location.state.post_id)==="undefined"){
            console.log("一次编辑");
            userIdInProps = this.props.location.state.userId;
        }
        else{
            console.log("二次编辑")；
        }

        try {
            userIdInProps = this.props.location.state.userId;
            postIdInProps = this.props.location.state.post_id;
            console.log(postIdInProps);
            console.log(userIdInProps);
            
            // this.setState({
            //         post_id: postIdInProps,
            //         user_id: userIdInProps
            //     }
            // )

            //get请求一定要写成get('url',{params: data})
            $axios.get('/user/post/searchPost', { post_id: postIdInProps }).then(res => {
                console.log(res)
                this.setState((preState) => {
                    return {
                        post_id: postIdInProps,
                        user_id: res.data.user_id,
                        currentTitle: res.data.post_title,
                        content: res.data.post_content,
                        currentCover: null//若为原封面,二次编辑无法选择封面
                    }
                })

            })
            //得到原来的标签
            $axios.get('/user/post/searchLabel',{post_id: postIdInProps}).then(res => {
                console.log(res.data)
                this.setState({
                    labelArray: res.data
                })
            })


        } catch (err) {
            console.log("一次编辑")
        }

        Quill.register('modules/imageDrop', ImageDrop);
        //Quill.register('modules/imageResize', ImageResize);
        Quill.register('formats/emoji', EmojiBlot);
        const textbox = this.refs.textarea;

        const container = [
            ['bold', 'italic', 'underline'],        // toggled buttons
            ['blockquote'],

            // [{ 'header': 1 }, { 'header': 2 }],               // custom button values
            [{ 'list': 'ordered' }, { 'list': 'bullet' }],
            [{ 'script': 'sub' }, { 'script': 'super' }],      // superscript/subscript
            // [{ 'indent': '-1' }, { 'indent': '+1' }],          // outdent/indent
            // [{ 'direction': 'rtl' }],                         // text direction

            // [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

            [{ 'color': [] }],          // dropdown with defaults from theme
            // [{ 'font': [] }],
            [{ 'align': [] }],
            ['image'],
            ['clean'],                                         // remove formatting button
            ['emoji'], //emoji表情，设置了才能显示

        ];//必须叫container,下面才能自定义！！！！！

        const options = {
            minHeight: "200px",
            debug: 'warn',
            modules: {
                'emoji-toolbar': true,  //是否在工具栏展示出来
                "emoji-textarea": false, //我不需要emoji展示在文本框所以设置为false
                "emoji-shortname": true,
                toolbar: {
                    container,
                    handlers: {
                        // 'image':this.selectImage.bind(this)
                        'image': () => {
                            this.refs.uploadRef.click()
                        }
                    }
                },               
                imageDrop: true,//这里的imageDrop名字要和上面的'modules/imageDrop'一样

            },
            placeholder: '请输入文本...',
            readOnly: false,
            theme: 'snow',
            
        };

        this.editor = new Quill(textbox, options);//textbox是富文本编辑器的位置
        this.editor.on('text-change', this.handleChange.bind(this));
        this.setState({editorOnload: 1})
        this.fetchUploadToken();

    }

    render() {
        // if (this.state.post_id == null) {

            console.log(this.state.post_id)
            console.log(this.state.user_id)
            console.log(this.state.currentCover)
            console.log(this.state.currentTitle)
            console.log(this.state.content)
            console.log(this.state.labelArray)
        
             if (this.state.rewrite === 0 && this.state.content != null && this.state.editorOnload === 1 ) {
                //编辑器已挂载 且 原贴未回写 且state中的内容已更新 才执行pastHTML
                console.log(411)
                this.editor.pasteHTML(this.state.content)
                this.setState({
                content: this.editor.root.innerHTML,
                rewrite: 1
                })
                console.log(this.state.content);
            }

            return (
                <div>
                    <div className="top" >
                        <LeftCircleOutlined 
                            className="backIcon"   
                            onClick={()=>{
                                this.props.history.push({pathname:'/home', state:{userId: this.state.user_id}})                                 
                            }}                     
                        ></LeftCircleOutlined>

                        {/**帖子提交 */}
                        <button
                            className="submitButton"
                            onClick={() => {
                                this.handleSubmit();
                            }}>发帖</button>

                    </div>
                    {/* 帖子标题 */}
                    <Input
                        value={this.state.currentTitle}
                        placeholder='请输入标题...'
                        ref='titleRef'
                        id='titleId'
                        onChange={() => {
                            console.log(document.getElementById('titleId').value);
                            // this.state.currentTitle = document.getElementById('titleId').value;
                            this.setState({ currentTitle: document.getElementById('titleId').value });
                            console.log(this.state.currentTitle);
                        }}>

                    </Input>

                    {/* 确定富文本编辑器的位置 */}
                    <div ref="textarea"
                        height="200px"
                    ></div>
                    <div className="tips">最多只能添加9张图片哦~</div>

                    {/* 上传图片 */}
                    <Upload
                        name='file'
                        action='http://upload.qiniu.com'
                        data={
                            {
                                'token': this.state.uploadToken,
                                'fileKey': Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1
                            }
                            // this.getUploadToken
                        }
                        beforeUpload={this.beforeUpload.bind(this)}
                        onChange={this.handleUploadChange}
                        showUploadList={false}
                    >
                        <button ref="uploadRef" style={{ display: 'none' }}>
                            Click to Upload
                        </button>
                    </Upload>

                    <a ref='addLabel'
                        onClick={() => {
                            this.setState({ labelVisible: true });
                        }}
                        style={{ color: "pink", fontSize: 5 }}
                    >+添加标签</a>

                    {/**添加标签的弹出框 */}
                    <Popup 
                        visible={this.state.labelVisible}
                        onMaskClick={() => {
                            this.setState({ labelVisible: false })
                        }}
                        bodyStyle={{
                            borderTopLeftRadius: '30px',
                            borderTopRightRadius: '30px',
                            minHeight: '40vh',
                          }}
                       >
                        <div className="labelInputArea">
                            <input
                                id="labelInput"
                                placeholder="请输入标签..."
                            />

                            <Button style={{ color: 'pink' }}
                                onClick={() => {
                                    if (this.state.labelArray.length < 10) {
                                        let flag = 0
                                        let inputVal = document.getElementById("labelInput").value
                                        for (var i = 0; i < this.state.labelArray.length; i++) {
                                            if (this.state.labelArray[i] === inputVal) { flag = 1 }
                                        }

                                        if (inputVal != null && inputVal != '') {
                                            if (flag === 0) {
                                                console.log(inputVal)
                                                let newArray = this.state.labelArray
                                                newArray.push(inputVal);
                                                //若写成let newArray = this.state.labelArray.push(document.getElementById("labelInput").value)就不行
                                                this.setState({
                                                    labelArray: newArray
                                                })
                                                document.getElementById("labelInput").value = null
                                                console.log(this.state.labelArray);
                                            } else {
                                                Toast.show({
                                                    content: "标签重复！",
                                                    fontSize: 10,
                                                    position: "bottom"                                                    
                                                })
                                            }
                                        } else {
                                            Toast.show({
                                                content: "标签不得为空！",
                                                fontSize: 10,
                                                position: "bottom"
                                            })
                                        }

                                    } else {
                                        Toast.show({
                                            content: "标签太多辣！",
                                            fontSize: 10,
                                            position: "bottom"
                                            })
                                    }
                                }}
                            >添加</Button>
                            <div className="tips">最多只能添加10个标签哦~</div>
                        
                        <ul className="ul">
                            {
                            this.state.labelArray.map((val,index) => {
                                
                                return <div>
                                    <li key={index} className="showLabel">
                                        <div className="label">{val}</div>
                                        <button className="labelDeleteButton" key={val} onClick={() => {
                                           let array = this.state.labelArray
                                            array.splice(index, 1);
                                            this.setState({
                                                labelArray: array
                                            });
                                        }}>删除</button>
                                    </li>
                                </div>
                            })}
                        </ul>
                        </div>
                    </Popup>


                    {/**提交错误的弹出框 */}
                    <Popup 
                         bodyStyle={{
                            borderTopLeftRadius: '30px',
                            borderTopRightRadius: '30px',
                            minHeight: '30vh',
                          }}
                        visible={this.state.submitErrorVisible}
                        onMaskClick={() => {
                            this.setState({ submitErrorVisible: false })
                        }}
                        >

                        <div className="errorPopup">
                            <div className="errMessage" >{this.state.errMessage}</div>

                            {/* 上传封面  */}
                            <Upload
                                name='file'
                                action='http://upload.qiniu.com'
                                data={
                                    {
                                        'token': this.state.uploadToken,
                                        'fileKey': Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1
                                    }
                                    // this.getUploadToken
                                }
                                beforeUpload={this.beforeUpload.bind(this)}
                                onChange={this.handleUploadChangeCover}
                                showUploadList={false}
                            >
                                <button ref="coverRef" style={{ display: 'none' }}>
                                    Click to Upload
                            </button>
                            </Upload>

                            {/* 上传封面按钮 */}
                            <div
                                className="coverUpload"
                                onClick={() => {
                                    this.refs.coverRef.click();
                                }}
                                style={{ width: 200, height: 200, }}

                            >
                                <button
                                    ref='coverButton'
                                    style={{ display: 'none' }}
                                >
                                </button>
                                <PlusCircleOutlined ref="coverButton" className="PlusCircleOutlined" />
                                <div ref='coverImg' >
                                    <img src={this.state.currentCoverUrl} style={{ maxHeight: 200, maxWidth: 200 }}></img>
                                </div>
                            </div>
                        </div>
                    </Popup>
                </div>
            )
    }

    handleSubmit() {
        this.setState({ loadingIcon: true });
        if (this.state.labelArray.length === 0) {
            Toast.show({
                content: '至少添加一个标签',
                fontSize: 10,
                position: 'bottom'
            })
        }
        else {

            Toast.show({
                icon: 'loading',
                content: '加载中…',
            })

            console.log(this.state.currentTitle);
            console.log(this.state.content);
            let json = null
            if (this.state.post_id === null) {
                //一次发帖
                let newPost_id;
                json = {
                    'user_id': this.state.user_id,
                    'post_title': this.state.currentTitle,
                    'post_content': this.state.content,
                    'cover_url': this.state.currentCoverUrl
                };

                $axios.post('/user/post/publish', json).then(res => {
                    Toast.clear();
                    if (res.code === 200) {
                        //提交传标签(label_id是上传帖子之后返回的uuid生成的帖子id)
                        let label = {
                            'post_id': res.message,
                            'labelArray': this.state.labelArray
                        }
                        $axios.post('/user/post/label', label).then(res => {
                            if (res.code === 200) {
                                Toast.show({
                                    content: "提交帖子成功",
                                    fontSize: 10,
                                    duration: 2000,
                                    position: 'bottom',
                                    afterClose: () => {
                                        this.props.history.push({pathname:'/home', state:{user_id: this.state.user_id}})                                    
                                      },
                                })
                            }
                        })
                    }
                    else if (res.code === 100) {
                        //帖子内容没有图片
                        this.setState({ errMessage: res.message, submitErrorVisible: 'block', coverDisplay: true });
                    }
                    else {
                        Toast.show({
                            content: res.message,
                            fontSize: 10,
                            position: 'bottom',
                        })
                    }
                    console.log(res);


                });
            }
            else {
                //二次发帖
                json = {
                    'post_id': this.state.post_id,
                    'user_id': this.state.user_id,
                    'post_title': this.state.currentTitle,
                    'post_content': this.state.content,
                    'post_cover': this.state.currentCoverUrl
                };

                $axios.post('/user/post/updatePost', json).then(res => {
                    Toast.clear();
                    if (res.code === 200) {
                        Toast.show({
                            content: "修改帖子成功",
                            fontSize: 10,
                            duration: 2000,
                            position: 'bottom',
                            afterClose: () => {
                                this.props.history.push({pathname:'/home', state:{post_id: this.state.post_id,user_id: this.state.user_id}})                                    
                              }
                        })
                        //提交传标签(label_id是上传帖子之后返回的uuid生成的帖子id)
                        let label = {
                            'post_id': this.state.post_id,
                            'labelArray': this.state.labelArray
                        }
                        $axios.post('/user/post/updateLabel', label)
                    }
                    else if (res.code === 100) {
                        //帖子内容没有图片
                        this.setState({ errMessage: res.message, submitErrorVisible: 'block', coverDisplay: true });
                    }
                    else {
                        Toast.show({
                            content: res.message,
                            fontSize: 10,
                            position: 'bottom',
                        })
                    }
                    console.log(res);
                });
            }
        }
    }

    handleChange() {
        // let {value}=this.state;
        this.setState({ content: this.editor.root.innerHTML })
        console.log(this.state.content);
    }

    beforeUpload(file) {
        return true;

    }

    // 访问后端，获取请求上传凭证
    fetchUploadToken = () => {
        $axios.get('/upload/token/get', {}).then(res => {
            Toast.clear();
            console.log(res);
            this.setState({
                uploadToken: res.message,
                fileKey: Date.now() + Math.floor(Math.random() * (999999 - 100000) + 100000) + 1
            })
        })
    }

    // 获取上传凭证
    getUploadToken = () => {
        return {
            token: this.state.uploadToken,
            key: this.state.fileKey
        }
    }

    // 获取回传的文件地址
    handleUploadChange = info => {
        if (info.file.status === 'done') {
            const imageKey = info.file.response.key
            const uploadUrl = "http://r31xm6gn5.hd-bkt.clouddn.com/" + imageKey;
            console.log(uploadUrl);

            //将图片插入编辑器
            const addImageRange = this.editor.getSelection();
            const cursorPosition = 0 + (addImageRange !== null ? addImageRange.index : 0);
            this.editor.insertEmbed(cursorPosition, 'image', uploadUrl);//插入图片//react无法读本地图片！！
            this.editor.setSelection(cursorPosition + 1);//光标位置加1
        }
    }

    //封面上传后的操作
    handleUploadChangeCover = info => {
        if (info.file.status === 'done') {
            const imageKey2 = info.file.response.key
            const uploadUrl2 = "http://r31xm6gn5.hd-bkt.clouddn.com/" + imageKey2;
            console.log(uploadUrl2);
            this.setState({ currentCoverUrl: uploadUrl2 });
            console.log(this.state.currentCoverUrl);
            this.refs.coverButton.style = 'display:none';
            this.refs.coverImg.style = 'display:block';
        }
    }
}




export default Post