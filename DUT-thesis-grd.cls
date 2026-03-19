%==================================================
%% DUT-thesis-grd.cls for DUT Thesis
%% version: 2.0
%% last update: Apr 27th, 2026
%%==================================================

%% =================================================================
%% 本文结构目录（按编号）
%% 1) 基础声明（内核与类信息）
%% 2) 类选项（主文件可传入的选项）
%% 3) 选项变量（控制模板行为）
%% 3.1 变量声明与默认值
%% 3.2 选项解析与处理
%% 4) 加载父类（ctexbook）
%% 5) 宏包加载（集中管理）
%% 6) 固定文本与默认值（label / value）
%% 6.1 封面（label / value）
%% 6.2 声明（label / value）
%% 6.3 委员会（label / value）
%% 6.4 未使用变量（label / value）
%% 7) 主文件接口（供 MAIN.tex 调用）
%% 7.1 封面接口
%% 7.2 声明接口
%% 7.3 委员会接口
%% 7.4 未使用变量接口
%% 7.5 工具函数与辅助宏
%% 8) 版面与标题样式（全局排版规则）
%% 8.1 行距与标题层级
%% 8.2 目录样式与双语目录接口
%% 8.3 页眉页脚样式
%% 8.4 双面空白页控制（openright）
%% 8.5 前置/正文页码风格
%% 9) 表格、数学常量与定理环境
%% 9.1 表格列类型扩展
%% 9.2 常用数学常量
%% 9.3 定理与证明环境
%% 10) 字体与图表题注
%% 10.1 英文字体设置
%% 10.2 图表题注与编号
%% 10.3 图像扩展名
%% 11) 参考文献与浮动体参数
%% 11.1 引用与浮动体比例
%% 11.2 编号格式
%% 12) 代码与算法环境
%% 12.1 中文破折号
%% 12.2 listings 代码环境
%% 12.3 算法环境
%% 13) 超链接与列表间距
%% 13.1 hyperref 参数
%% 13.2 枚举环境间距
%% 14) 辅助宏与元信息
%% 14.1 参考文献样式
%% 14.2 DUTspace 空白宏
%% 14.3 答辩日期拆分
%% 14.4 类文件版本信息
%% 14.5 下划线工具
%% 15) 标题页与前后置环境
%% 15.1 中文标题页字体
%% 15.2 中文标题页绘制
%% 15.3 原创性声明与授权页
%% 15.4 答辩委员会页
%% 15.5 摘要与关键词
%% 15.6 中英文目录
%% 15.7 参考文献环境
%% 15.8 后置部分环境
%% 16) 计数器与目录深度
%% 附) 正文可用命令与环境索引（不参与主编号）
%% =================================================================

%% =================================================================
%% 正文可用命令与环境索引（按章节/小节）
%% 说明：采用 .h 头文件风格，仅声明“用法原型”；具体实现见对应章节。
%%
%% [7.1 封面接口]
%%   \title[title_mark]{title}
%%   \author{author_name}
%%   \studentnumber{student_id}
%%   \advisor{advisor_name}
%%   \major{major_name}
%%
%% [7.2 声明接口]
%%   \defenddate{yyyy年mm月dd日}
%%
%% [7.3 委员会接口]
%%   \committeeTitleOne{title_1} ... \committeeTitleFive{title_5}
%%   \committeeMemberOne{name_1} ... \committeeMemberFive{name_5}
%%   \defenseCandidate{candidate_name}
%%   \defenseLocation{location}
%%
%% [7.4 扩展接口（默认未启用）]
%%   \classification{text}
%%   \confidential{text}
%%   \udc{text}
%%   \serialnumber{text}
%%   \school{text}
%%   \degree{text}
%%   \chairman{text}
%%   \advisorinstitute{text}
%%   \vtitle{text}
%%   \institute{text}
%%   \version
%%
%% [7.5 工具命令]
%%   \Anon{text}
%%   \Hide{text}
%%   \circled[phantom]{content}
%%
%% [8.2 双语目录写入]
%%   \BiChapter{cn_title}{en_title}
%%   \BiSection{cn_title}{en_title}
%%   \BiSubsection{cn_title}{en_title}
%%
%% [8.4 清页控制]
%%   \DUTDisableBlankPage
%%   \DUTEnableBlankPage
%%
%% [8.5 页码命令（重定义）]
%%   \frontmatter
%%   \mainmatter
%%
%% [9.3 定理类环境]
%%   \begin{algo}...\end{algo}
%%   \begin{thm}...\end{thm}
%%   \begin{lem}...\end{lem}
%%   \begin{prop}...\end{prop}
%%   \begin{cor}...\end{cor}
%%   \begin{defn}...\end{defn}
%%   \begin{conj}...\end{conj}
%%   \begin{exmp}...\end{exmp}
%%   \begin{rem}...\end{rem}
%%   \begin{case}...\end{case}
%%
%% [11.1 引用命令]
%%   \upcite{bib_key}
%%
%% [12.1 中文破折号命令]
%%   \cndash
%%
%% [14.2/14.5 辅助命令]
%%   \DUTspace[n]
%%   \DUTunderline[width]{content}
%%
%% [15.2 标题页命令（重定义）]
%%   \maketitle
%%
%% [15.3 声明页命令]
%%   \makeDeclareOriginal
%%
%% [15.4 委员会页命令]
%%   \committee
%%
%% [15.5 摘要/关键词]
%%   \begin{abstract}...\end{abstract}
%%   \begin{englishabstract}...\end{englishabstract}
%%   \keywords{keywords_cn}
%%   \englishkeywords{keywords_en}
%%   \beginatevenpage
%%
%% [15.6 目录命令（重定义/新增）]
%%   \tableofcontents
%%   \tableofengcontents
%%
%% [15.7 参考文献环境（重定义）]
%%   \begin{thebibliography}{max_label}...\end{thebibliography}
%%
%% [15.8 后置部分环境]
%%   \begin{publications}...\end{publications}
%%   \begin{projects}{max_label}...\end{projects}
%%   \begin{resume}...\end{resume}
%%   \begin{resumesection}{section_title}...\end{resumesection}
%%   \begin{resumeli}{item_title}...\end{resumeli}
%%   \begin{conclusion}...\end{conclusion}
%%   \begin{thanks}...\end{thanks}
%%   \begin{symbolnote}...\end{symbolnote}
%%   \begin{denotation}...\end{denotation}
%% =================================================================



%% =====================================================================
%% 1) 基础声明（内核与类信息）
%% =====================================================================
%% 用途：限制最低 LaTeX 版本，便于排查兼容性
%% 用法：保持为当前模板要求的最低版本
\NeedsTeXFormat{LaTeX2e}[2005/12/01]

%% 用途：声明类名与版本号，供日志与工具识别
%% 用法：更新模板版本时同步修改
\ProvidesClass{DUT-thesis-grd}[2026/04/27 v2.0 DUT-thesis-grd document class]

%% =====================================================================
%% 2) 类选项（主文件可传入的选项）
%% =====================================================================
%% 未知选项转交给 ctexbook
%% 用途：把未知选项传给 ctexbook（如字号、纸张等）
%% 用法：\documentclass[12pt,a4paper]{DUT-thesis-grd}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}

%% =====================================================================
%% 3) 选项变量（控制模板行为）
%% =====================================================================
%% 3.1 变量声明与默认值
%% 用途：在类内部保存选项状态
%% 用法：主文件通过 twoside/hide 等选项控制
\newif\ifDUT@twoside %% 是否启用双面排版
\DUT@twosidefalse
\newif\ifDUT@Hidden  %% 是否启用隐藏功能
\DUT@Hiddenfalse

%% =====================================================================
%% 3.2 选项解析与处理
%% =====================================================================
%% 用途：定义可用选项及其效果
%% 用法：\documentclass[twoside,hide]{DUT-thesis-grd}
\DeclareOption{twoside}{\DUT@twosidetrue}
\DeclareOption{oneside}{\DUT@twosidefalse}
\DeclareOption{hide}{\DUT@Hiddentrue}
\DeclareOption{nohide}{\DUT@Hiddenfalse}

%% 用途：处理并固化选项
\ProcessOptions\relax

%% =====================================================================
%% 4) 加载父类（ctexbook）
%% =====================================================================
%% 用途：继承 ctexbook 的中文排版能力
%% 用法：根据单双面选项选择 openright/openany
\ifDUT@twoside
  \LoadClass[zihao=-4,a4paper,twoside,openright,UTF8,space=auto]{ctexbook}
\else
  \LoadClass[zihao=-4,a4paper,oneside,openany,UTF8,space=auto]{ctexbook}
\fi

%% =====================================================================
%% 5) 宏包加载（集中管理）
%% =====================================================================
%% 依赖包清单（按功能分组）
%% 用途：统一维护依赖，便于调整与排错
%% 用法：新增包尽量放在此处，并保持注释简洁
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm,mathrsfs} %% 数学公式/定理/符号/黑体
\RequirePackage{upgreek}                               %% 直立希腊字母
\RequirePackage{xstring}                               %% 字符串拆分/判断
\RequirePackage{forloop}                               %% 循环生成内容
\RequirePackage{tikz}                                  %% 画圈字符
\RequirePackage{etoolbox}                              %% 条件判断补丁
\RequirePackage{pifont}                                %% 符号集
\RequirePackage{setspace}                              %% 行距控制
\RequirePackage{graphicx}                              %% 插图
\RequirePackage{subcaption}                            %% 子图环境
\RequirePackage{makecell}                              %% 单元格内换行
\RequirePackage{wrapfig}                               %% 文字环绕图
\RequirePackage{threeparttable}                        %% 三线表注释
\RequirePackage{dcolumn}                               %% 小数点对齐
\RequirePackage{multirow}                              %% 多行单元格
\RequirePackage{booktabs}                              %% 表格横线
\RequirePackage{tabularx}                              %% 自适应列宽
\RequirePackage[justification=centering]{caption}      %% 图表题注格式
\RequirePackage[list=off]{bicaption}                   %% 双语题注
\RequirePackage[numbers,square,comma,sort&compress]{natbib} %% 引用样式
\RequirePackage{xcolor}                                %% 颜色
\RequirePackage{float}                                 %% 强制浮动位置
\RequirePackage{listings}                              %% 代码环境
\RequirePackage{algorithm}                             %% 算法浮动体
\RequirePackage{algorithmicx}                          %% 算法排版
\RequirePackage{algpseudocode}                         %% 伪代码样式
\RequirePackage{enumitem}                              %% 枚举间距
\RequirePackage{supertabular}                          %% 跨页表格
\RequirePackage{titletoc}                              %% 目录格式
\RequirePackage{fancyhdr}                              %% 页眉页脚
\RequirePackage[version=4]{mhchem}                     %% 化学式排版
\RequirePackage{siunitx}                               %% 物理单位
%% geometry 统一版面参数
\RequirePackage[
  paper=a4paper,
  top=3.5cm,
  bottom=2.5cm,
  left=2.7cm,
  right=2.7cm,
  headheight=0.50cm,
  footskip=1.47cm
]{geometry}                                            %% 版芯与页边距
%% hyperref 放在最后
\RequirePackage{hyperref}                              %% 书签/超链接

%% =====================================================================
%% 6) 固定文本与默认值（label / value）
%% =====================================================================
%% 6.1 封面（label / value）
%% 用途：封面与正文标题等固定文本与默认值
%% 用法：label 不建议在主文件改，value 通过接口覆盖
\def\DUT@label@major{学科、~~专业:}
\def\DUT@label@author{作~~者~~姓~~名:}
\def\DUT@label@studentnumber{学~~~~~~~~~~~~~~号:}
\def\DUT@label@advisor{指~~导~~教~~师:}
\def\DUT@label@defenddate{答~~辩~~日~~期:}
\def\DUT@label@cover@degree{硕士学位论文}
\def\DUT@label@cover@spec{大连理工大学硕士学位论文格式规范}
\def\DUT@label@cover@spec@en{Format Criterion of Master Degree Thesis of DUT}
\def\DUT@label@cover@school{大连理工大学}
\def\DUT@label@cover@school@en{Dalian University of Technology}
\def\DUT@label@cover@note{注：对于专业学位硕士,企业或实践导师必填,写法样例:XXX(企业导师)或XXX(实践导师)}
\def\DUT@label@abstract{摘要}
\def\DUT@label@keywords{关键词：}
\def\DUT@label@englishkeywords{Key Words:~}
\def\DUT@label@conclusion{结论}
\def\DUT@label@publications{攻读硕士学位期间科研项目及科研成果}
\def\DUT@label@projects{攻读学位期间参与的项目}
\def\DUT@label@resume{作者简介}
\def\DUT@label@reference{参考文献}
\def\DUT@label@reference@title{参~~考~~文~~献}
\def\DUT@label@thanks{致谢}
\def\DUT@label@thanks@title{致~~~~~~谢}
\def\DUT@label@symbolnote{符号说明}
\def\DUT@label@denotation{主要符号表}
\def\DUT@label@toc{目录}
\def\DUT@label@toc@title{目　　录}
\def\DUT@label@listfigure{图~目~录}
\def\DUT@label@listtable{表~目~录}
\def\DUT@label@listingname{代码}
\def\DUT@label@proofname{证明}
\def\DUT@label@algorithm@input{Input:}
\def\DUT@label@algorithm@output{Output:}
\def\DUT@label@figure@en{Fig.}
\def\DUT@label@table@en{Tab.}
\def\DUT@label@headschoolname{大连理工大学硕士学位论文}
\def\DUT@label@headspecname{大连理工大学硕士学位论文格式规范}
\def\DUT@label@abstract@en{ABSTRACT}
\def\DUT@label@contents@en{TABLE OF CONTENTS}
\def\DUT@label@references@en{References}
\def\DUT@label@publications@en{Achievements}
\def\DUT@label@resume@en{CV}
\def\DUT@label@thanks@en{Acknowledgements}

\def\DUT@value@title{论文题目}
\def\DUT@value@author{姓名}
\def\DUT@value@advisor{导师}
\def\DUT@value@major{专业}
\def\DUT@value@studentnumber{学号}
\def\DUT@value@defenddate{2026年03月18日}

%% 6.2 声明（label / value）
%% 用途：声明页固定文字
%% 用法：声明日期由 \DUT@value@defenddate 拆分
\def\DUT@label@original{学位论文原创性申明}
\def\DUT@label@authorization{大连理工大学学位论文版权使用授权书}
\def\DUT@label@author@sign{作~~者~~签~~名~~：}
\def\DUT@label@supervisor@sign{导~~师~~签~~名~~：}
\def\DUT@label@date{日期：}
\def\DUT@label@thesistitle{学位论文题目：}
\def\DUT@label@originalcontent{本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经指明引用的内容外，学位论文不含任何其他个人、法人或者非法人组织已经发表或尚未发表的作品，且学位论文中已经指明作者姓名或者名称、作品名称的内容，不影响该作品的正常使用，也不存在不合理地损害相关权利人的合法权益的任何情形。对学位论文研究做出重要贡献的个人和法人或者非法人组织，均已在论文中以明确方式标明，且不存在任何著作权纠纷。\par 若因声明不实，本人愿意为此承当相应的法律责任。}
\def\DUT@label@authorizationcontent{本人完全了解大连理工大学有关学位论文知识产权的规定，在校攻读学位期间论文工作的知识产权属于大连理工大学，允许论文被查阅和借阅。学校有权保留论文并向国家有关部门或机构送交论文的复印件和电子版，可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印、或扫描等复制手段保存和汇编本学位论文。}
\def\DUT@label@bookmark@statement{声明}

%% 6.3 委员会（label / value）
%% 用途：答辩委员会页固定文字与默认值
%% 用法：用于答辩委员会版面
\def\DUT@label@committee{硕士学位论文答辩委员会}
\def\DUT@label@committee@candidate{答辩人:}
\def\DUT@label@committee@members{答辩委员会委员:}
\def\DUT@label@committee@date{答辩日期:}
\def\DUT@label@committee@location{答辩地点:}
\def\DUT@label@committee@chairnote{（注:主席）}
\def\DUT@label@bookmark@committee{委员会}

\def\DUT@value@committee@titleone{委员职称1}
\def\DUT@value@committee@titletwo{委员职称2}
\def\DUT@value@committee@titlethree{委员职称3}
\def\DUT@value@committee@titlefour{委员职称4}
\def\DUT@value@committee@titlefive{委员职称5}
\def\DUT@value@committee@profone{委员1}
\def\DUT@value@committee@proftwo{委员2}
\def\DUT@value@committee@profthree{委员3}
\def\DUT@value@committee@proffour{委员4}
\def\DUT@value@committee@proffive{委员5}
\def\DUT@value@defense@candidate{答辩人}
\def\DUT@value@defense@location{答辩地点}

%% 6.4 未使用变量（label / value）
%% 用途：当前类文件未引用，但保留以便扩展
%% 用法：如需启用，请在正文中显式引用
\def\DUT@label@appendix{附录}
\def\DUT@label@chairman{答辩委员会主席}
\def\DUT@label@classification{中图分类号：}
\def\DUT@label@confidential{密级}
\def\DUT@label@degree{申~~~~请~~~~学~~~~位}
\def\DUT@label@figure@appendix{附录-图}
\def\DUT@label@figure@appendix@en{App.Fig.}
\def\DUT@label@institute{学~~~~院~~~~名~~~~称}
\def\DUT@label@school{学~位~授~予~单~位}
\def\DUT@label@serialnumber{编号}
\def\DUT@label@table@appendix{附录-表}
\def\DUT@label@table@appendix@en{App.Tab.}
\def\DUT@label@thesis{学位论文}
\def\DUT@label@title{论文题目}
\def\DUT@label@udc{UDC\!分类号：}

\def\DUT@value@advisorinstitute{单位}
\def\DUT@value@chairman{答辩委员会主席}
\def\DUT@value@classification{分类号}
\def\DUT@value@confidential{密级}
\def\DUT@value@degree{申请学位}
\def\DUT@value@institute{学院名称}
\def\DUT@value@school{学位授予单位}
\def\DUT@value@serialnumber{编号}
\def\DUT@value@titlemark{\DUT@value@title}
\def\DUT@value@udc{UDC分类号}
\def\DUT@value@vtitle{竖排论文题目}

%% =====================================================================
%% 7) 主文件接口（供 MAIN.tex 调用）
%% =====================================================================
%% 7.1 封面接口
%% 用途：主文件填写封面与正文标题信息
%% 用法：示例 \title{论文题目}、\author{姓名}
\renewcommand{\title}[2][\DUT@value@title]{%
  \def\DUT@value@title{#2}%
  \def\DUT@value@titlemark{\MakeUppercase{#1}}%
}
\renewcommand{\author}[1]{\def\DUT@value@author{#1}}
\newcommand{\studentnumber}[1]{\def\DUT@value@studentnumber{#1}}
\newcommand{\advisor}[1]{\def\DUT@value@advisor{#1}}
\newcommand{\major}[1]{\def\DUT@value@major{#1}}

%% 7.2 声明接口
%% 用途：声明日期由 \defenddate 自动拆分
%% 用法：示例 \defenddate{2026年03月18日}
\newcommand{\defenddate}[1]{\def\DUT@value@defenddate{#1}}

%% 7.3 委员会接口
%% 用途：填写答辩委员会信息
%% 用法：示例 \committeeMemberOne{姓名}
\newcommand{\committeeTitleOne}[1]{\def\DUT@value@committee@titleone{#1}}
\newcommand{\committeeTitleTwo}[1]{\def\DUT@value@committee@titletwo{#1}}
\newcommand{\committeeTitleThree}[1]{\def\DUT@value@committee@titlethree{#1}}
\newcommand{\committeeTitleFour}[1]{\def\DUT@value@committee@titlefour{#1}}
\newcommand{\committeeTitleFive}[1]{\def\DUT@value@committee@titlefive{#1}}
\newcommand{\committeeMemberOne}[1]{\def\DUT@value@committee@profone{#1}}
\newcommand{\committeeMemberTwo}[1]{\def\DUT@value@committee@proftwo{#1}}
\newcommand{\committeeMemberThree}[1]{\def\DUT@value@committee@profthree{#1}}
\newcommand{\committeeMemberFour}[1]{\def\DUT@value@committee@proffour{#1}}
\newcommand{\committeeMemberFive}[1]{\def\DUT@value@committee@proffive{#1}}
\newcommand{\defenseCandidate}[1]{\def\DUT@value@defense@candidate{#1}}
\newcommand{\defenseLocation}[1]{\def\DUT@value@defense@location{#1}}

%% 7.4 未使用变量接口
%% 用途：当前类文件未引用，但保留以便扩展
%% 用法：如需启用，请在正文中显式引用
\newcommand{\classification}[1]{\def\DUT@value@classification{#1}}
\newcommand{\confidential}[1]{\def\DUT@value@confidential{#1}}
\newcommand{\udc}[1]{\def\DUT@value@udc{#1}}
\newcommand{\serialnumber}[1]{\def\DUT@value@serialnumber{#1}}
\newcommand{\school}[1]{\def\DUT@value@school{#1}}
\newcommand{\degree}[1]{\def\DUT@value@degree{#1}}
\newcommand{\chairman}[1]{\def\DUT@value@chairman{#1}}
\newcommand{\advisorinstitute}[1]{\def\DUT@value@advisorinstitute{#1}}
\newcommand{\vtitle}[1]{\def\DUT@value@vtitle{#1}}
\newcommand{\institute}[1]{\def\DUT@value@institute{#1}}
\newcommand{\version}{\DUTfileversion}

%% =====================================================================
%% 7.5 工具函数与辅助宏
%% =====================================================================
%% 用途：提供匿名/隐藏/画圈等通用功能
%% 用法：按需在正文或模板内部调用
\newcounter{Num}%% 计数器：配合 \Anon 输出遮罩

%% 匿名输出：若启用 hide，输出等长“×”，否则原样输出
\newcommand{\Anon}[1]{
  \ifDUT@Hidden
    \StrLen{#1}[\StringLen]% 计算输入字符串长度
    \forloop{Num}{0}{\theNum<\StringLen}{×}% 按长度输出“×”，
  \else
    #1
  \fi
}

%% 隐藏输出：若启用 hide，输出空白，否则原样输出
\newcommand{\Hide}[1]{
  \ifDUT@Hidden
  \else
    #1
  \fi
}

%% 允许多行公式在页间尽量自由断页
\allowdisplaybreaks[4]

%% 画圈字符：可选参数控制圆圈尺寸，必选参数为字符内容
\newcommand{\circled}[2][]{%
  \tikz[baseline=(char.base)]{%
    \node[shape=circle,draw,inner sep=1pt] (char)
      {\phantom{\ifblank{#1}{#2}{#1}}};%
    \node at (char.center) {\makebox[0pt][c]{#2}};%
  }%
}
%% 保护 \circled，避免移动参数出错
\robustify{\circled}

%% =====================================================================
%% 8) 版面与标题样式（全局排版规则）
%% =====================================================================
%% 用途：统一行距与各级标题格式
%% 用法：一般无需在主文件中修改

%% =====================================================================
%% 8.1 行距与标题层级
%% =====================================================================

%% 用途：设置全文行距
%% 用法：需要更改时调整此倍率
\setstretch{1.35}

%% 用途：设置章/节/小节/小小节的格式
%% 用法：统一在此处改字号、间距、编号样式
\ctexset{chapter={
  name = {},
  number = {\arabic{chapter}},
  format = {\CTEXifname{\raggedright\heiti\zihao{3}}{\centering\heiti\zihao{-3}}},
  pagestyle = {DUT@headings},
  beforeskip = 12bp,
  afterskip  = 28bp,
  fixskip    = true,
}}

%% 用途：节标题格式
\ctexset{section={
  format     = {\heiti\zihao{4}},
  beforeskip = 12bp,
  afterskip  = 8bp,
  fixskip    = true,
}}

%% 用途：小节标题格式
\ctexset{subsection={
  format     = {\raggedright\heiti\zihao{-4}},
  beforeskip = 8bp,
  afterskip  = 6bp,
  fixskip    = true,
}}
%% titlesec 放在这里是刻意的：原版模板也是在此处加载
%% 原因是 titlesec 会影响标题间距的计算与生效时机，
%% 如果把它放到宏包区或更靠前的位置，后面的 \ctexset
%% 就会按照“titlesec 已经介入”的方式重新计算，导致节标题
%% 的前后间距与原版不一致（我们之前就遇到过偏大/偏小的问题）。
%% 因此这里保持“先设 section/subsection，再加载 titlesec，
%% 最后设 subsubsection”的顺序，以保证间距表现与原版一致。
\RequirePackage{titlesec}                              %% 标题格式
%% 用途：小小节标题格式
\ctexset{subsubsection={
  name       = {(,)},
  number     = {\arabic{subsubsection}},
  format     = {\raggedright\heiti\zihao{-4}},
  beforeskip = 8bp,
  afterskip  = 6bp,
  fixskip    = true,
}}

%% =====================================================================
%% 8.2 目录样式与双语目录接口
%% =====================================================================
%% 用途：设置目录/图表目录标题
%% 用法：如需改名称，修改 label 或此处
%% ctex 宏的重定义：目录、图目录、表目录标题
%% =================================================================
\renewcommand{\contentsname}{\DUT@label@toc}
\renewcommand{\listfigurename}{\DUT@label@listfigure}
\renewcommand{\listtablename}{\DUT@label@listtable}

%% =====================================================================
%% 进入目录相关文件时临时关闭超链接边框显示，避免目录中出现彩色方框。
\addtocontents{toc}{\protect\hypersetup{hidelinks}}%目录
\addtocontents{toe}{\protect\hypersetup{hidelinks}}%英文目录
\addtocontents{lot}{\protect\hypersetup{hidelinks}}%表目录
\addtocontents{lof}{\protect\hypersetup{hidelinks}}%图目录

%% 使用 titletoc 调整目录条目缩进、点线与页码对齐方式。
\titlecontents{chapter}[0pt]{\songti\zihao{-4}}
  {\thecontentslabel\hspace{0.1\ccwd}}{}
  {\hspace{0em}\titlerule*{.}\contentspage}

\titlecontents{section}[2\ccwd]{\songti\zihao{-4}}%%左侧2字节缩进
  {\thecontentslabel\hspace{0.4\ccwd}}{}
  {\hspace{0em}\titlerule*{.}\contentspage}

\titlecontents{subsection}[4\ccwd]{\songti\zihao{-4}}%%左侧4字节缩进
  {\thecontentslabel\hspace{0.5\ccwd}}{}
  {\hspace{0em}\titlerule*{.}\contentspage}

\titlecontents{figure}[0pt]{\songti\zihao{-4}}
  {\figurename\thecontentslabel~~}{\hspace*{-1.5cm}}
  {\hspace{0em}\titlerule*{.}\hspace{-0.5em}\contentspage}
  
\titlecontents{table}[0pt]{\songti\zihao{-4}}
  {\tablename\thecontentslabel~~}{\hspace*{-1.5cm}}
  {\hspace{0em}\titlerule*{.}\hspace{-0.5em}\contentspage}

%% 创建双语目录函数：
%% 在输出中文标题的同时，向英文目录文件 toe 写入对应英文标题。
\newcommand{\BiChapter}[2]{
  \chapter{#1}
  \addcontentsline{toe}{chapter}{\protect\numberline{\csname thechapter\endcsname}#2}
}

\newcommand{\BiSection}[2]{
  \section{#1}
  \addcontentsline{toe}{section}{\protect\numberline{\csname thesection\endcsname}#2}
}

\newcommand{\BiSubsection}[2]{
  \subsection{#1}
  \addcontentsline{toe}{subsection}{\protect\numberline{\csname thesubsection\endcsname}#2}
}

%% =====================================================================
%% 8.3 页眉页脚样式
%% =====================================================================
%% 用途：统一页眉页脚显示内容
%% 用法：如需改字样，修改 \DUT@label@headschoolname 等

%% 定义 DUT@empty 样式：完全清空页眉页脚内容
\fancypagestyle{DUT@empty}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

%% 同步约束系统 empty 样式，保证所有“空白页”都无页眉页脚
\fancypagestyle{empty}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

%% 定义 DUT@headings 样式：居中显示文字页眉、页码页脚
\fancypagestyle{DUT@headings}{
  \fancyhf{}
  \fancyfoot[C]{\songti\zihao{5} \thepage}  %%页脚中部显示页码
  \fancyhead[CO]{\zihao{5}{\songti \DUT@label@headschoolname}}%%页眉奇数页
  \fancyhead[CE]{\zihao{5}{\songti \DUT@label@headspecname}}%%页眉偶数页
}

%% 全局默认页眉页脚与 plain 样式
%% 用途：为未显式设置的页面提供统一样式
%% 用法：默认启用 fancy，plain 用于章首页
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\songti \zihao{5} \DUT@label@headschoolname}
\fancyfoot[C]{\songti \zihao{5} {\thepage}}

%% plain 样式通常用于章首页
\fancypagestyle{plain}{
  \fancyhf{}%
  \fancyfoot[C]{\songti \zihao{5} ~---~{\thepage}~---~}
}

%% =====================================================================
%% 8.4 双面空白页控制（openright）
%% =====================================================================
%% 用途：双面模式下插入空白页并隐藏页眉页脚
%% 说明：该逻辑会被后文多处 \cleardoublepage 调用，
%%       因此只保留一个“权威版本”，避免重复封装导致效果叠加或失效。
%% 用法：保持默认即可，需改逻辑时改此处

%% 在双面模式下重定义 \cleardoublepage
%% 当前页为偶数页时插入空白页，并显式使用 DUT@empty 样式以隐藏页眉页脚
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifodd\c@page
    \else
      \hbox{}%
      \thispagestyle{empty}%
      \newpage
      \if@twocolumn
        \hbox{}%
        \thispagestyle{empty}%
        \newpage
      \fi
    \fi
  \fi
}

%% 提供主文件开关：需要临时关闭“空白页”时调用
%% 典型用途：草稿阶段或只想连续排版时（不想插入空白页）
\let\DUT@cleardoublepage\cleardoublepage
\newcommand{\DUTDisableBlankPage}{\let\cleardoublepage\clearpage}
\newcommand{\DUTEnableBlankPage}{\let\cleardoublepage\DUT@cleardoublepage}

%% =====================================================================
%% 8.5 前置/正文页码风格
%% =====================================================================
%% 用途：前置部分罗马数字、正文阿拉伯数字
%% 用法：保持默认即可
%% 前置部分：使用大写罗马数字页码。
\renewcommand{\frontmatter}{
  \if@openright\cleardoublepage\else\clearpage\fi %%根据 openright 选项决定是否强制从右页开始
  \@mainmatterfalse %%设置 \if@mainmatter 条件为 false，表示当前处于前置部分
  \pagenumbering{Roman}
  \pagestyle{DUT@headings}%%使用 DUT@headings 样式显示页眉页脚
}

%% 正文部分：使用阿拉伯数字页码。
\renewcommand{\mainmatter}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{DUT@headings}
}

%% =====================================================================
%% 9) 表格、数学常量与定理环境
%% =====================================================================
%% 用途：集中管理表格列类型、常用数学符号与定理环境
%% 用法：通常无需改动，按需微调格式

%% =====================================================================
%% 9.1 表格列类型扩展
%% =====================================================================
%% 用途：提供按小数点对齐的列类型 d
%% 用法：\begin{tabular}{d{2.3}} ... \end{tabular}
\newcolumntype{d}[1]{D{.}{.}{#1}}

%% =====================================================================
%% 9.2 常用数学常量
%% =====================================================================
%% 用途：直立体 e/i/j 与微分符号 d
%% 用法：公式中使用 \me \mi \mj \dif
\newcommand{\me}{\mathrm{e}}
\newcommand{\mi}{\mathrm{i}}
\newcommand{\mj}{\mathrm{j}}
\newcommand{\dif}{\,\mathrm{d}}

%% =====================================================================
%% 9.3 定理与证明环境
%% =====================================================================
%% 用途：按章编号的定理类环境
%% 用法：\begin{thm}...\end{thm} 等
\theoremstyle{definition}
\newtheorem{algo}{算法~}[chapter]
\newtheorem{thm}{定理~}[chapter]
\newtheorem{lem}[thm]{引理~}
\newtheorem{prop}[thm]{命题~}
\newtheorem{cor}[thm]{推论~}
\newtheorem{defn}{定义~}[chapter]
\newtheorem{conj}{猜想~}[chapter]
\newtheorem{exmp}{例~}[chapter]
\newtheorem{rem}{注~}
\newtheorem{case}{情形~}

%% 用途：proof 环境标题改为中文
%% 用法：自动生效，无需调用
\renewcommand{\proofname}{\bf \DUT@label@proofname}

%% =====================================================================
%% 10) 字体与图表题注
%% =====================================================================

%% =====================================================================
%% 10.1 英文字体设置
%% =====================================================================
%% 用途：统一英文正文字体/无衬线/等宽字体
%% 用法：按需替换字体名称
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}

%% =====================================================================
%% 10.2 图表题注与编号
%% =====================================================================
%% 用途：统一图表题注字体与间距
%% 用法：修改分隔符/字体即可影响全局题注
\DeclareCaptionLabelSeparator{f_t_caption_space}{\hspace{1\ccwd}}
\DeclareCaptionFont{f_t_caption_font}{\songti\zihao{5}}

%% 用途：设置双语题注中的英文标题名称
\captionsetup[figure][bi-second]{name=\DUT@label@figure@en}
\captionsetup[table][bi-second]{name=\DUT@label@table@en}

%% 用途：统一代码题注（如“代码3.1：xxx”）字体与分隔
\captionsetup[lstlisting]{
  font     = {f_t_caption_font},
  labelsep = f_t_caption_space,
}

%% 用途：设置表标题位置与上下间距
\captionsetup[table]{
  font      = {f_t_caption_font},
  labelsep  = f_t_caption_space,
  position  = top,
  aboveskip = 6bp,
  belowskip = 6bp,
}
\numberwithin{table}{chapter}

%% 用途：设置图标题位置与上下间距
\captionsetup[figure]{
  font      = {f_t_caption_font},
  labelsep  = f_t_caption_space,
  position  = bottom,
  aboveskip = 6bp,
  belowskip = 6bp,
}

%% =====================================================================
%% 10.3 图像扩展名
%% =====================================================================
%% 用途：\includegraphics 未写扩展名时的查找顺序
\DeclareGraphicsExtensions{.pdf,.eps,.png,.jpg,.jpeg}

%% =====================================================================
%% 11) 参考文献与浮动体参数
%% =====================================================================

%% =====================================================================
%% 11.1 引用与浮动体比例
%% =====================================================================
%% 用途：定义上标式引用命令
%% 用法：文字\upcite{ref}
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

%% 用途：调整浮动体比例，减少“图表无法放置”
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}

%% =====================================================================
%% 11.2 编号格式
%% =====================================================================
%% 用途：统一公式、图、表编号为“章号.序号”
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}

%% =====================================================================
%% 12) 代码与算法环境
%% =====================================================================

%% =====================================================================
%% 12.1 中文破折号
%% =====================================================================
%% 用途：绘制中文破折号
\newcommand{\cndash}{%
  \rule{0.0em}{0pt}\rule[0.35em]{1.4em}{0.05em}\rule{0.2em}{0pt}%
}

%% =====================================================================
%% 12.2 listings 代码环境
%% =====================================================================
%% 用途：统一代码块显示样式
\lstset{
  basicstyle         = \footnotesize,
  keywordstyle       = \color{blue!90}\bfseries,
  commentstyle       = \color{red!50!green!50!blue!50},
  stringstyle        = \ttfamily,
  numbers            = left,
  numberstyle        = \tiny,
  numbersep          = 1.5em,
  stepnumber         = 1,
  frame              = shadowbox,
  rulesepcolor       = \color{red!20!green!20!blue!20},
  framextopmargin    = 2pt,
  framexbottommargin = 2pt,
  xleftmargin        = 4em,
  xrightmargin       = 4em,
  tabsize            = 4,
  keepspaces         = true,
  showspaces         = false,
  showstringspaces   = false,
  columns            = flexible,
  fontadjust,
  breaklines         = true,
  breakautoindent    = true,
  breakindent        = 4em,
  captionpos         = t,
  abovecaptionskip   = -3pt,
  belowcaptionskip   = 3pt,
  aboveskip          = 1em,
  texcl              = true,
  %% 兼顾中文、换行与数学环境输入
  extendedchars      = false,
  mathescape         = true,
}

%% 用途：代码环境标题名称
\renewcommand{\lstlistingname}{\DUT@label@listingname}

%% =====================================================================
%% 12.3 算法环境
%% =====================================================================
%% 用途：算法环境编号与输入/输出标签
\@ifundefined{c@algorithm}{\newcounter{algorithm}[chapter]}{}
\renewcommand{\algorithmicrequire}{\textbf{\DUT@label@algorithm@input}}
\renewcommand{\algorithmicensure}{\textbf{\DUT@label@algorithm@output}}
\renewcommand{\thealgorithm}{\thechapter.\arabic{algorithm}}%%算法编号格式为“章号.序号”

%% =====================================================================
%% 13) 超链接与列表间距
%% =====================================================================

%% =====================================================================
%% 13.1 hyperref 参数
%% =====================================================================
%% 用途：PDF 书签与链接显示风格
\hypersetup{
  bookmarksnumbered,%
  linktoc=all,
  colorlinks=true,
  citecolor=black,
  filecolor=cyan,
  linkcolor=black,
  linkbordercolor=black,
  urlcolor=black,
  plainpages=false,%
  pdfstartview=FitH
}

%% =====================================================================
%% 13.2 枚举环境间距
%% =====================================================================
%% 用途：统一 enumerate/itemize/description 间距
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
% \setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=0pt}
% \setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
 
%% =====================================================================
%% 14) 辅助宏与元信息
%% =====================================================================

%% =====================================================================
%% 14.1 参考文献样式
%% =====================================================================
%% 用途：统一参考文献样式（国标）
\bibliographystyle{GBT7714-2005NLang}

%% =====================================================================
%% 14.2 DUTspace 空白宏
%% =====================================================================
%% 用途：输出若干个汉字宽度的水平空白
%% 用法：\DUTspace[2] 表示约两个汉字宽空格
\newcommand{\DUTspace}[1][1]{\hspace{#1\ccwd}}

%% =====================================================================
%% 14.3 答辩日期拆分
%% =====================================================================
%% 用途：从 \DUT@value@defenddate 拆分 年/月/日
%% 用法：在声明页生成前调用
\newcommand{\DUT@splitdefenddate}{%
  \def\DUT@defend@year{\DUT@value@defenddate}%
  \def\DUT@defend@month{}%
  \def\DUT@defend@day{}%
  \IfSubStr{\DUT@value@defenddate}{年}{%
    \StrBefore{\DUT@value@defenddate}{年}[\DUT@defend@year]%
    \StrBetween{\DUT@value@defenddate}{年}{月}[\DUT@defend@month]%
    \StrBetween{\DUT@value@defenddate}{月}{日}[\DUT@defend@day]%
  }{}%
}

%% =====================================================================
%% 14.4 类文件版本信息
%% =====================================================================
%% 用途：提取类文件版本信息供模板自身使用
\def\DUT@getfileinfo#1 #2 #3\relax#4\relax{%
  \def\DUTfiledate{#1}%
  \def\DUTfileversion{#2}%
  \def\DUTfileinfo{#3}%
}
\edef\reserved@a{\csname ver@DUT-thesis-grd.cls\endcsname}
\expandafter\DUT@getfileinfo\reserved@a\relax? ? \relax\relax

%% =====================================================================
%% 14.5 下划线工具
%% =====================================================================
%% 用途：在指定宽度内居中下划线
\def\DUT@underline[#1]#2{%
  \underline{\hbox to #1{\hfill#2\hfill}}%
}
%% 用途：带可选宽度参数的下划线
\def\DUTunderline{\@ifnextchar[\DUT@underline\underline}

%% =====================================================================
%% 15) 标题页与前后置环境
%% =====================================================================

%% =====================================================================
%% 15.1 中文标题页字体
%% =====================================================================
%% 用途：行楷字体族定义
\setCJKfamilyfont{xkai}{STXingkai}
\newcommand{\xkai}{\CJKfamily{xkai}}

%% =====================================================================
%% 15.2 中文标题页绘制
%% =====================================================================
%% 用途：生成中文封面页
%% 用法：主文件调用 \maketitle
\renewcommand{\maketitle}{%
  \cleardoublepage
  \thispagestyle{empty}

  \begin{center}
    \vskip \stretch{1}%垂直方向上放可伸缩空白

    \parbox[t][4.40cm][c]{\textwidth}{%
      \begin{center}
        {\songti\zihao{-1}\textsf{\DUT@label@cover@degree}\\}
        \vspace{1.34cm}
        {\heiti\zihao{2}\textsf{\DUT@label@cover@spec}\\}
        \vspace{0.13cm}
        {\zihao{3}\textbf{\DUT@label@cover@spec@en}\\}
      \end{center}
    }

    \vspace{50.2mm}

    {\songti\zihao{-3}\DUT@label@author}\DUTunderline[170pt]{\songti\zihao{-3}\DUT@value@author}
    \vskip 10pt
    {\songti\zihao{-3}\DUT@label@studentnumber}\DUTunderline[170pt]{\songti\zihao{-3}\DUT@value@studentnumber}
    \vskip 10pt
    {\songti\zihao{-3}\DUT@label@advisor}\DUTunderline[170pt]{\songti\zihao{-3}\DUT@value@advisor}
    \vskip 10pt
    {\songti\zihao{-3}\DUT@label@major}\DUTunderline[170pt]{\songti\zihao{-3}\DUT@value@major}
    \vskip 10pt
    {\songti\zihao{-3}\DUT@label@defenddate}\DUTunderline[170pt]{\songti\zihao{-3}\DUT@value@defenddate}
    \vskip 3pt
    \colorbox{yellow}{\DUT@label@cover@note}
    \\ \vspace{31.4mm}
    {\Large\xkai \DUT@label@cover@school\\}
    \vspace{2.3mm}
    {\zihao{-4} \DUT@label@cover@school@en}
  \end{center}

  \vskip \stretch{0.5}%垂直方向上放可伸缩空白
  \clearpage%清页
  \if@twoside%双面模式下插入空白页
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% =====================================================================
%% 15.3 原创性声明与授权页
%% =====================================================================
%% 用途：生成原创性声明与授权页
%% 用法：主文件调用 \makeDeclareOriginal
\newcommand{\makeDeclareOriginal}{%
  \cleardoublepage
  \pdfbookmark[0]{\DUT@label@bookmark@statement}{statement}%pdf加书签“声明”，内部锚点为statement
  \thispagestyle{empty}%无页眉页脚
  \DUT@splitdefenddate

  \begin{center}
    \parbox[t][1.52cm][c]{\textwidth}
    {\heiti\zihao{-2}\centerline \DUT@label@original}%%声明标题
  \end{center}

  \vskip 10pt
  {\songti\zihao{-4}\DUT@label@originalcontent}%%声明内容
  \vskip 10pt
  {\songti\zihao{-4}\DUT@label@thesistitle}\DUTunderline[303pt]{\DUT@value@title}
  \vskip 3pt
  \indent{\songti\zihao{-4}\DUT@label@author@sign}
  \DUTunderline[8em]{\includegraphics[height=0.8cm]{figures/figure2}}
  \hspace{1.3em}
  {\songti\zihao{-4}\DUT@label@date}\DUTunderline[4em]{\DUT@defend@year}~年~\DUTunderline[2em]{\DUT@defend@month}~月~\DUTunderline[2em]{\DUT@defend@day}~日~

  \vskip 20mm

  \begin{center}
    {\heiti\zihao{-2} \DUT@label@authorization}
  \end{center}

  \vskip 10pt
  {\songti\zihao{-4} \DUT@label@authorizationcontent}
  \vskip 25pt
  {\songti\zihao{-4}\DUT@label@thesistitle}\DUTunderline[303pt]{\DUT@value@title}
  \vskip 3pt
  \indent{\songti\zihao{-4}\DUT@label@author@sign}
  \DUTunderline[10.65em]{\includegraphics[height=0.8cm]{figures/figure2}}
  {\songti\zihao{-4}\DUT@label@date}\DUTunderline[3em]{\DUT@defend@year}年~\DUTunderline[2em]{\DUT@defend@month}~月~\DUTunderline[2em]{\DUT@defend@day}~日~
  \vskip 3pt
  \indent{\songti\zihao{-4}\DUT@label@supervisor@sign}
  \DUTunderline[10.65em]{\includegraphics[height=0.8cm]{figures/figure1}}
  {\songti\zihao{-4}\DUT@label@date}\DUTunderline[3em]{\DUT@defend@year}~年~\DUTunderline[2em]{\DUT@defend@month}~月~\DUTunderline[2em]{\DUT@defend@day}~日~
  \vskip 3pt

  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% =====================================================================
%% 15.4 答辩委员会页
%% =====================================================================
%% 用途：生成答辩委员会信息页
%% 用法：主文件调用 \committee
\newcommand{\committee}{%
  \cleardoublepage
  \pdfbookmark[0]{\DUT@label@bookmark@committee}{council}
  \thispagestyle{empty}

  \begin{center}
    \parbox[t][1.52cm][c]{\textwidth}
    {\heiti\zihao{-2}\centerline \DUT@label@committee}
  \end{center}

  \vskip 50pt
  {\songti\zihao{4} \noindent{\DUT@label@committee@candidate\DUT@value@defense@candidate}}
  \vskip 35pt
  {\songti\zihao{4} \noindent{\DUT@label@committee@members}}
  \vskip 25pt

  \begin{center}
    {\zihao{4}
      \begin{tabular}{rl}
        \DUT@value@committee@titleone   & {\DUTunderline[150pt]{\DUT@value@committee@profone}}\songti\zihao{5}\DUT@label@committee@chairnote\\[0.7cm]
        \DUT@value@committee@titletwo   & \DUTunderline[150pt]{\DUT@value@committee@proftwo}\\[0.7cm]
        \DUT@value@committee@titlethree & \DUTunderline[150pt]{\DUT@value@committee@profthree}\\[0.7cm]
        \DUT@value@committee@titlefour  & \DUTunderline[150pt]{\DUT@value@committee@proffour}\\[0.7cm]
        \DUT@value@committee@titlefive  & \DUTunderline[150pt]{\DUT@value@committee@proffive}
      \end{tabular}}
  \end{center}

  \vskip 40pt
  {\songti\zihao{4} \noindent{\DUT@label@committee@date~\DUT@value@defenddate}}
  \vskip 15pt
  {\songti\zihao{4} \noindent{\DUT@label@committee@location\DUT@value@defense@location}}

  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% =====================================================================
%% 15.5 摘要与关键词
%% =====================================================================
%% 用途：定义中英文摘要与关键词环境
%% 用法：\begin{abstract}...\end{abstract}
\newenvironment{abstract}{%
  \cleardoublepage
  \chapter{\DUT@label@abstract}
}{}

%% 用途：强制从偶数页（左页）开始后续内容
\newcommand{\beginatevenpage}{%
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% 中文关键词
\newcommand{\keywords}[1]{%
  \vspace{2ex}\indent{\heiti\zihao{-4} \DUT@label@keywords} #1%
}

%% 英文摘要环境
\newenvironment{englishabstract}{%
  \clearpage
  \chapter{\DUT@label@abstract@en}
}{}

%% 英文关键词
\newcommand{\englishkeywords}[1]{%
  \vspace{2ex}\indent{\bf\zihao{-4} \DUT@label@englishkeywords} #1%
}

%% =====================================================================
%% 15.6 中英文目录
%% =====================================================================
%% 用途：重定义中英文目录命令
\renewcommand{\tableofcontents}{%
  \if@twocolumn% 如果是双栏排版
    \@restonecoltrue\onecolumn% 切换到单栏模式以生成目录，并使@restonecol标志为 true，以便后续恢复双栏模式
  \else
    \@restonecolfalse
  \fi
  \chapter*{\DUT@label@toc@title}% 章标题不编号，但显示“目录”
  \addcontentsline{toc}{chapter}{\contentsname}%将目录添加到 toc 中
  \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%%设置页眉左右两侧的文本为大写“目录”
  %% \chapter* 在 hyperref 下会自动生成书签，这里不再手动 \pdfbookmark，避免重复“目录”
  \@starttoc{toc}% 从 toc 文件读取目录内容并生成目录
  \if@restonecol\twocolumn\fi
}

%% 英文目录标题文本
\newcommand{\DUT@engcontentsname}{\makebox[\textwidth][c]{\bf\zihao{-3}\DUT@label@contents@en}}

%% 英文目录：从 toe 文件读取
\newcommand{\tableofengcontents}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\texorpdfstring{\DUT@engcontentsname}{\DUT@label@contents@en}}
  \addcontentsline{toc}{chapter}{\DUT@label@contents@en}
  %% 不向 toe 自身写入“目录标题”，避免英文目录正文出现该标题条目
  \@mkboth{\MakeUppercase\DUT@label@contents@en}{\MakeUppercase\DUT@label@contents@en}
  %% \chapter* 已自动生成英文目录书签；移除手动书签以避免重复项
  \@starttoc{toe}%
  \if@restonecol\twocolumn\fi
}

%% =====================================================================
%% 15.7 参考文献环境
%% =====================================================================
%% 用途：重定义参考文献列表格式
\renewenvironment{thebibliography}[1]{%
    \songti\zihao{5}
    \chapter*{\DUT@label@reference@title}
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \addcontentsline{toc}{chapter}{\DUT@label@reference}
    \addcontentsline{toe}{chapter}{\DUT@label@references@en}
    \list{\@biblabel{\@arabic\c@enumiv}}%效果如[1][2]
      {%
        \settowidth\labelwidth{\@biblabel{#1}}%测量最大标签宽度，例如[99]，并将结果存储在 \labelwidth 中
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \setlength{\parsep}{1mm}
        \setlength{\labelsep}{0.5em}
        \setlength{\itemsep}{0.05pc}
        \setlength{\listparindent}{0in}
        \setlength{\itemindent}{0in}
        \setlength{\rightmargin}{0in}
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand{\theenumiv}{\@arabic\c@enumiv}%
      }%
    \sloppy%断行设置，允许在单词边界处断行，以避免过长的行导致溢出。
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m%让句号后的间距处理保持合适状态。
  }{%
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%防止参考文献列表为空时出现错误，改为发出警告。
    \endlist
  }

%% =====================================================================
%% 15.8 后置部分环境
%% =====================================================================
%% 用途：成果/项目/简历/结论/致谢/符号表等环境
\newenvironment{publications}{%
  \ifodd\c@page
  \else
    \clearpage
    \phantom{s}
    \thispagestyle{empty}
  \fi
  \chapter*{\DUT@label@publications}
  \addcontentsline{toc}{chapter}{\DUT@label@publications}
  \addcontentsline{toe}{chapter}{\DUT@label@publications@en}
}{}

%% 项目环境：样式类似参考文献列表
\newenvironment{projects}[1]{%
  \chapter{\DUT@label@projects}%攻读硕士学位期间科研项目
  \@mkboth{\MakeUppercase\DUT@label@projects}{\MakeUppercase\DUT@label@projects}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
    {%
      \settowidth\labelwidth{\@biblabel{#1}}%
      \leftmargin\labelwidth
      \advance\leftmargin\labelsep
      \@openbib@code
      \usecounter{enumiv}%
      \let\p@enumiv\@empty
      \renewcommand{\theenumiv}{\@arabic\c@enumiv}%
    }%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `projects' environment}}%
  \endlist
}

%% 作者简介环境
\newenvironment{resume}{%
  \ifodd\c@page
  \else
    \clearpage
    \phantom{s}
    \thispagestyle{empty}
  \fi
  \chapter*{\DUT@label@resume}
  \addcontentsline{toc}{chapter}{\DUT@label@resume}
  \addcontentsline{toe}{chapter}{\DUT@label@resume@en}
}{}

%% 简历中的一级小节
\newenvironment{resumesection}[1]{%
  {\noindent\normalfont\bfseries #1}%
  \list{}{\labelwidth\z@ \leftmargin 2\ccwd}%
  \item\relax
}{\endlist}

%% 简历中的缩进列表项
\newenvironment{resumeli}[1]{%
  {\noindent\normalfont\bfseries #1}%
  \list{}{%
    \labelwidth\z@
    \leftmargin 4\ccwd
    \itemindent -2\ccwd
    \listparindent\itemindent
  }%
  \item\relax
}{\endlist}

%% 结论环境：无编号章节，但加入目录
\newenvironment{conclusion}{%
  \chapter*{\DUT@label@conclusion}
  \@mkboth{\DUT@label@conclusion}{\DUT@label@conclusion}%
  \addcontentsline{toc}{chapter}{\DUT@label@conclusion}
}{}

%% 致谢环境
\renewenvironment{thanks}{%
  \ifodd\c@page
  \else
    \clearpage
    \phantom{s}
    \thispagestyle{empty}
  \fi
  \chapter*{\DUT@label@thanks@title}
  \addcontentsline{toc}{chapter}{\DUT@label@thanks}
  \addcontentsline{toe}{chapter}{\DUT@label@thanks@en}
}{}

%% 符号说明环境：依赖前文定义的 \DUT@label@symbolnote
\newenvironment{symbolnote}{%
  \chapter{\DUT@label@symbolnote}
  \fangsong
}{}

%% 主要符号表环境
\newenvironment{denotation}{\chapter{\DUT@label@denotation}}{}

%% =====================================================================
%% 16) 计数器与目录深度
%% =====================================================================
%% 用途：控制章节编号深度与目录显示深度
\setcounter{secnumdepth}{4}  %% 章节编号的深度细到 subsubsection
\setcounter{tocdepth}{2}     %% 目录显示到 subsection

\endinput
%%
%% End of file `dutmaster-xetex.cls'.




