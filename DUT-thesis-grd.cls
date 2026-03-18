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
%% =================================================================

%% =================================================================
%% 预备修改内容：改了哪些部分要明确输出给我看。
%% 1、将所有固定文本改为可覆盖的变量，按照固定表头为label，表头后可修改的为value，并提供接口函数供主文件调用。
%% 2、函数接口命名规范化，统一使用英文单词，避免中文拼音缩写。
%% 3、在每行代码后面增加注释说明，明确每个函数的作用、参数含义以及使用方法。
%% 4、将整个文件的结构顺序和重新调整，符合标准的 LaTeX 类文件编写规范，增强可读性和维护性。
%% 5、在本文最前面注释区，总结所有本文定义的函数，以及重定义的函数，并按照功能分类进行说明，方便用户查阅和使用。
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
%% 5) 依赖包清单（按功能分组）
%% 用途：统一维护依赖，便于调整与排错
%% 用法：新增包尽量放在此处，并保持注释简洁
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm,mathrsfs} %% 数学公式/定理/符号/黑体
\RequirePackage{upgreek}                               %% 直立希腊字母
\RequirePackage{xstring}                               %% 字符串拆分/判断
\RequirePackage{forloop}                               %% 循环生成内容
\RequirePackage{ulem}                                  %% 下划线/删除线
\RequirePackage{tikz}                                  %% 画圈字符
\RequirePackage{etoolbox}                              %% 条件判断补丁
\RequirePackage{pifont}                                %% 符号集
\RequirePackage{setspace}                              %% 行距控制
\RequirePackage{xltxtra}                               %% XeLaTeX 字体支持
\RequirePackage{graphicx}                              %% 插图
\RequirePackage{subfigure}                             %% 并列子图
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
\RequirePackage{titlesec}                              %% 标题格式
\RequirePackage{titletoc}                              %% 目录格式
\RequirePackage{ifthen}                                %% 条件判断
\RequirePackage{ifpdf}                                 %% 输出模式判断
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
\def\DUT@label@submitdate{论文提交日期}
\def\DUT@label@table@appendix{附录-表}
\def\DUT@label@table@appendix@en{App.Tab.}
\def\DUT@label@thesis{学位论文}
\def\DUT@label@title{论文题目}
\def\DUT@label@udc{UDC\!分类号：}

\def\DUT@value@advisorinstitute{单位}
\def\DUT@value@chairman{答辩委员会主席}
\def\DUT@value@classification{分类号}
\def\DUT@value@confidential{密级}
\def\DUT@value@defense@date{答辩日期}
\def\DUT@value@degree{申请学位}
\def\DUT@value@institute{学院名称}
\def\DUT@value@school{学位授予单位}
\def\DUT@value@serialnumber{编号}
\def\DUT@value@statement@year{年}
\def\DUT@value@statement@month{月}
\def\DUT@value@statement@day{日}
\def\DUT@value@submitdate{论文提交日期}
\def\DUT@value@templateversion{v2.0}
\def\DUT@value@titlemark{\DUT@value@title}
\def\DUT@value@udc{UDC分类号}
\def\DUT@value@vtitle{竖排论文题目}

%% =====================================================================
%% 7) 主文件接口（供 MAIN.tex 调用）
%% =====================================================================
%% 7.1 封面接口
%% 用途：主文件填写封面与正文标题信息
%% 用法：示例 \title{论文题目}、\author{姓名}
\renewcommand\title[2][\DUT@value@title]{%
  \def\DUT@value@title{#2}%
  \def\DUT@value@titlemark{\MakeUppercase{#1}}%
}
\renewcommand\author[1]{\def\DUT@value@author{#1}}
\newcommand\studentnumber[1]{\def\DUT@value@studentnumber{#1}}
\newcommand\advisor[1]{\def\DUT@value@advisor{#1}}
\newcommand\major[1]{\def\DUT@value@major{#1}}
\newcommand\defenddate[1]{\def\DUT@value@defenddate{#1}}

%% 7.2 声明接口
%% 用途：声明日期由 \defenddate 自动拆分
%% 用法：无需额外接口

%% 7.3 委员会接口
%% 用途：填写答辩委员会信息
%% 用法：示例 \committeeMemberOne{姓名}
\newcommand\committeeTitleOne[1]{\def\DUT@value@committee@titleone{#1}}
\newcommand\committeeTitleTwo[1]{\def\DUT@value@committee@titletwo{#1}}
\newcommand\committeeTitleThree[1]{\def\DUT@value@committee@titlethree{#1}}
\newcommand\committeeTitleFour[1]{\def\DUT@value@committee@titlefour{#1}}
\newcommand\committeeTitleFive[1]{\def\DUT@value@committee@titlefive{#1}}
\newcommand\committeeMemberOne[1]{\def\DUT@value@committee@profone{#1}}
\newcommand\committeeMemberTwo[1]{\def\DUT@value@committee@proftwo{#1}}
\newcommand\committeeMemberThree[1]{\def\DUT@value@committee@profthree{#1}}
\newcommand\committeeMemberFour[1]{\def\DUT@value@committee@proffour{#1}}
\newcommand\committeeMemberFive[1]{\def\DUT@value@committee@proffive{#1}}
\newcommand\defenseCandidate[1]{\def\DUT@value@defense@candidate{#1}}
\newcommand\defenseLocation[1]{\def\DUT@value@defense@location{#1}}

%% 7.4 未使用变量接口
%% 用途：当前类文件未引用，但保留以便扩展
%% 用法：如需启用，请在正文中显式引用
\newcommand\classification[1]{\def\DUT@value@classification{#1}}
\newcommand\confidential[1]{\def\DUT@value@confidential{#1}}
\newcommand\udc[1]{\def\DUT@value@udc{#1}}
\newcommand\serialnumber[1]{\def\DUT@value@serialnumber{#1}}
\newcommand\school[1]{\def\DUT@value@school{#1}}
\newcommand\degree[1]{\def\DUT@value@degree{#1}}
\newcommand\submitdate[1]{\def\DUT@value@submitdate{#1}}
\newcommand\chairman[1]{\def\DUT@value@chairman{#1}}
\newcommand\advisorinstitute[1]{\def\DUT@value@advisorinstitute{#1}}
\newcommand\vtitle[1]{\def\DUT@value@vtitle{#1}}
\newcommand\institute[1]{\def\DUT@value@institute{#1}}
\newcommand\statementDateYear[1]{\def\DUT@value@statement@year{#1}}
\newcommand\statementDateMonth[1]{\def\DUT@value@statement@month{#1}}
\newcommand\statementDateDay[1]{\def\DUT@value@statement@day{#1}}
\newcommand{\version}{\DUT@value@templateversion}

%% =================================================================
%% 定义函数
%% =================================================================
\newcounter{Num}%% 定义一个计数器，用于循环输出“×”

%% 定义匿名函数\Anon{内容}：若启用 hide，则输出与原字符串长度相同数量的“×”，否则输出原字符串
\newcommand{\Anon}[1]{
  \ifDUT@Hidden
    \StrLen{#1}[\StringLen]% 计算输入字符串长度
    \forloop{Num}{0}{\theNum<\StringLen}{×}% 按长度输出“×”，
  \else
    #1
  \fi
}

%% 定义隐藏函数\Hide{内容}：若启用 hide，则输出空白，否则输出原字符串
\newcommand{\Hide}[1]{
  \ifDUT@Hidden
  \else
    #1
  \fi
}

\allowdisplaybreaks[4]   %% 允许多行公式在页间尽量自由断页

%% 定义生成带圈字符函数：圆圈大小参考#1参数，圈里显示#2参数
\newcommand{\circled}[2][]{%
  \tikz[baseline=(char.base)]{%
    \node[shape=circle,draw,inner sep=1pt] (char)
      {\phantom{\ifblank{#1}{#2}{#1}}};%
    \node at (char.center) {\makebox[0pt][c]{#2}};%
  }%
}
\robustify{\circled}%%加固画圈函数

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
\renewcommand\contentsname{\DUT@label@toc}
\renewcommand\listfigurename{\DUT@label@listfigure}
\renewcommand\listtablename{\DUT@label@listtable}

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
}

%% 定义 DUT@headings 样式：居中显示文字页眉、页码页脚
\fancypagestyle{DUT@headings}{
  \fancyhf{}
  \fancyfoot[C]{\songti\zihao{5} \thepage}  %%页脚中部显示页码
  \fancyhead[CO]{\zihao{5}{\songti \DUT@label@headschoolname}}%%页眉奇数页
  \fancyhead[CE]{\zihao{5}{\songti \DUT@label@headspecname}}%%页眉偶数页
}

%% =====================================================================
%% 8.4 双面空白页控制（openright）
%% =====================================================================
%% 用途：双面模式下插入空白页并隐藏页眉页脚
%% 用法：保持默认即可，需改逻辑时改此处

% %% 示例：在双面模式下重定义 \cleardoublepage
% %% 若当前页是偶数页，则插入空白页并取消页眉页脚
% \def\cleardoublepage{%
%   \clearpage
%   \if@twoside
%     \ifodd\c@page
%     \else
%       \thispagestyle{empty}%
%       \hbox{}\newpage
%       \if@twocolumn\hbox{}\newpage\fi
%     \fi
%   \fi
% }

%% 在双面模式下，重定义 \cleardoublepage：？？？？？？？？？？？？？？？？？？待修改
%% 如果当前页是偶数页，则插入一个真正的空白页，并取消页眉页脚。
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifodd\c@page
    \else
      \thispagestyle{empty}%
      \hbox{}\newpage
      \if@twocolumn\hbox{}\newpage\fi
    \fi
  \fi
}

\let\DUT@cleardoublepage\cleardoublepage%%将原始 \cleardoublepage 保存到 \DUT@cleardoublepage 中
\newcommand{\DUT@clearemptydoublepage}{%%定义新的 \DUT@clearemptydoublepage 命令：先设置该页为 DUT@empty 样式，再调用原始 \cleardoublepage 插入空白页
  \clearpage{
    \pagestyle{DUT@empty}
    \DUT@cleardoublepage
  }
}
\let\cleardoublepage\DUT@clearemptydoublepage%%将 \cleardoublepage 替换为新的 \DUT@clearemptydoublepage，这样在双面模式下自动插入的空白页就不会显示页眉页脚了

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

%% =================================================================
%% 英文字体设置
%% =================================================================
\setmainfont{Times New Roman}%% 设置正文字体为 Times New Roman
\setsansfont{Arial}%% 设置无衬线字体为 Arial
\setmonofont{Courier New}%% 设置等宽字体为 Courier New

%% =================================================================
%% 图片、表格、双语标题与图表题注设置
%% =================================================================

%% 以下若干宏包与设置用于控制图表标题样式。
%% 注意：原模板存在重复加载 amsmath / caption / booktabs 的情况；
%% 为尽量保持原始行为，这里仍然保留这些调用，只做排版与注释整理。

%% 图表标题：中文标题与编号间使用一个汉字宽度的间距。
\DeclareCaptionLabelSeparator{f_t_caption_space}{\hspace{1\ccwd}}%%定义一个汉字宽度的空白。
\DeclareCaptionFont{f_t_caption_font}{\songti\zihao{5}}%%定义caption 字体。
\captionsetup{%%？？？？？？？？？？？？？？？和后面好像可以合并写
  font     = {f_t_caption_font},
  labelsep = f_t_caption_space,
}

%% 图的英文第二标题名称
\captionsetup[figure][bi-second]{name=\DUT@label@figure@en}
%% 表的英文第二标题名称
\captionsetup[table][bi-second]{name=\DUT@label@table@en}

%% 表标题：置于表格上方
\captionsetup[table]{
  position  = top,
  aboveskip = 6bp,
  belowskip = 6bp,
}
\numberwithin{table}{chapter}

%% 图标题：置于图片下方
\captionsetup[figure]{
  position  = bottom,
  aboveskip = 6bp,
  belowskip = 6bp,
}

%% 若 \includegraphics 未显式写扩展名，则按下列顺序查找文件。
\DeclareGraphicsExtensions{.pdf,.eps,.png,.jpg,.jpeg}

%% =================================================================
%% 参考文献与浮动体参数
%% =================================================================
%% natbib：数字型方括号引用，多个引用自动排序并压缩。

%% 定义上标式引用函数，例如：文字\upcite{ref}
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

%% 重定义浮动体参数默认值，减少“图表无法放置”的概率。
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}

%% 公式、图、表编号格式统一为“章号.序号”，而不是整篇文档从头连续编号。
\renewcommand\theequation{\arabic{chapter}.\arabic{equation}}
\renewcommand\thefigure{\arabic{chapter}.\arabic{figure}}
\renewcommand\thetable{\arabic{chapter}.\arabic{table}}

%% =================================================================
%% 颜色、浮动体与代码环境
%% =================================================================

%% 中文破折号：通过规则线手工绘制
\newcommand{\cndash}{%
  \rule{0.0em}{0pt}\rule[0.35em]{1.4em}{0.05em}\rule{0.2em}{0pt}%
}

%% listings：源码显示环境
\lstset{%%？？？？？？？？？？？？等待调整先后顺序
  tabsize            = 4,
  frame              = shadowbox,
  commentstyle       = \color{red!50!green!50!blue!50},
  rulesepcolor       = \color{red!20!green!20!blue!20},
  keywordstyle       = \color{blue!90}\bfseries,
  showstringspaces   = false,
  stringstyle        = \ttfamily,
  keepspaces         = true,
  breakindent        = 22pt,
  numbers            = left,
  stepnumber         = 1,
  numberstyle        = \tiny,
  basicstyle         = \footnotesize,
  showspaces         = false,
  flexiblecolumns    = true,
  breaklines         = true,
  breakautoindent    = true,
  breakindent        = 4em,
  aboveskip          = 1em,
  fontadjust,
  captionpos         = t,
  framextopmargin    = 2pt,
  framexbottommargin = 2pt,
  abovecaptionskip   = -3pt,
  belowcaptionskip   = 3pt,
  xleftmargin        = 4em,
  xrightmargin       = 4em,
  texcl              = true,
  %% 兼顾中文、换行与数学环境输入
  extendedchars      = false,
  columns            = flexible,
  mathescape         = true,
  numbersep          = 1.5em,
}

%% listings 标题名称改为“代码”
\renewcommand{\lstlistingname}{\DUT@label@listingname}

%% 算法环境：编号按 chapter 计数
\@ifundefined{c@algorithm}{\newcounter{algorithm}[chapter]}{}
\renewcommand{\algorithmicrequire}{\textbf{\DUT@label@algorithm@input}}
\renewcommand{\algorithmicensure}{\textbf{\DUT@label@algorithm@output}}
\renewcommand\thealgorithm{\thechapter.\arabic{algorithm}}%%算法编号格式为“章号.序号”


%% hyperref package

%\definecolor{navyblue}{RGB}{0,0,128}   %增加海军蓝颜色
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

%% 三种枚举环境间距调节
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
% \setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=0pt}
% \setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}

%% =================================================================
%% 参考文献风格与内部辅助命令
%% =================================================================
\bibliographystyle{GBT7714-2005NLang}%%？？？？？？？？？？？为何不用2015国标

%% DUTspace：输出若干个汉字宽度的水平空白。
%% 例如 \DUTspace[2] 表示约两个汉字宽的空格。
\newcommand{\DUTspace}[1][1]{\hspace{#1\ccwd}}%%？？？？？？？？？感觉可以复用到图表标题

%% 从 \DUT@value@defenddate 中拆分 年/月/日（格式示例：2023年05月30日）
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

%% 提取类文件版本信息。不是给正文内容服务的，而是给模板自身的元信息服务。
%% 这里保留了历史兼容逻辑：名称仍然沿用旧模板中的 dutmaster-xetex.cls。
\def\DUT@getfileinfo#1 #2 #3\relax#4\relax{%%字符拆解器：将输入字符串按空格拆解为三部分，分别赋值给 #1、#2、#3，直到遇到 \relax 结束。
  \def\DUTfiledate{#1}%
  \def\DUTfileversion{#2}%
  \def\DUTfileinfo{#3}%
}
\expandafter\ifx\csname ver@dutmaster-xetex.cls\endcsname\relax
  \edef\reserved@a{\csname ver@ctextemp_dutmaster-xetex.cls\endcsname}
\else
  \edef\reserved@a{\csname ver@dutmaster-xetex.cls\endcsname}
\fi
\expandafter\DUT@getfileinfo\reserved@a\relax? ? \relax\relax

%% 定义\DUTunderline居中下划线函数：在指定宽度内居中放置内容，再整体加下划线。
\def\DUT@underline[#1]#2{%
  \underline{\hbox to #1{\hfill#2\hfill}}%
}
\def\DUTunderline{\@ifnextchar[\DUT@underline\underline}%%\@ifnextchar为3目运算符，如果下一个字符是[，则调用\DUT@underline，否则调用\underline

%% =================================================================
%% 中文标题页绘制
%% =================================================================
%% 这里定义行楷字体族，并且简化了使用方式，例如 \xkai{大连理工大学} 就可以直接输出行楷字体的校名。
\setCJKfamilyfont{xkai}{STXingkai}
\newcommand{\xkai}{\CJKfamily{xkai}}

%% 重定义绘制中文标题页。
%% 注意：当前页面中的若干占位文字、签名图片路径等都沿用原模板写法。
\renewcommand\maketitle{%
  \cleardoublepage
  \thispagestyle{empty}

  \begin{center}
    \vskip \stretch{1}%垂直方向上放可伸缩空白
    \def\tabcolsep{1pt}%调整表格的，好像没用上，难道在答辩委员会的地方用上了吗，这段语句生效到那个地方吗
    \def\arraystretch{1.5}%调整表格行高好像没用上

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
  \if@twoside%如果是双面模式，则插入一个空白页，并且该页不显示页眉页脚。
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% =================================================================
%% 原创性声明与版权授权页绘制：与中文标题页的使用beginend有何区别，可以改写成一样的吗
%% =================================================================
\newcommand\makeDeclareOriginal{%
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

%% =================================================================
%% 定义生成答辩委员会信息页函数
%% =================================================================
\newcommand\committee{%
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

%% =================================================================
%% 全局页眉页脚默认样式与 plain 样式
%% =================================================================
\pagestyle{fancy}%%这不是跟前面重合了吗，前面不是定义了DUT@headings样式吗，这里为什么又设置成fancy了，感觉可以合并成一个
\fancyhf{}
\fancyhead[C]{\songti \zihao{5} \DUT@label@headschoolname}
\fancyfoot[C]{\songti \zihao{5} {\thepage}}

%% plain 样式通常用于章首页。
\fancypagestyle{plain}{%好像没有生效
  \fancyhf{}%
  \fancyfoot[C]{\songti \zihao{5} \DUT@label@headschoolname}
  \fancyfoot[C]{\songti \zihao{5} ~---~{\thepage}~---~}%% 首页页脚格式
}

%% =================================================================
%% 摘要、关键词与偶数页起始控制
%% =================================================================
%% 中文摘要环境
\newenvironment{abstract}
  {%
    \cleardoublepage
    \chapter{\DUT@label@abstract}
  }
  {}

%% 强制从偶数页（左页）开始后续内容。
\newcommand\beginatevenpage{%怎么又来一个奇偶页控制
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

%% 中文关键词
\newcommand\keywords[1]{%
  \vspace{2ex}\indent{\heiti\zihao{-4} \DUT@label@keywords} #1%
}

%% 英文摘要环境
\newenvironment{englishabstract}%%
  {%
    \clearpage
    \chapter{\DUT@label@abstract@en}
  }
  {}

%% 英文关键词
\newcommand\englishkeywords[1]{%
  \vspace{2ex}\indent{\bf\zihao{-4} \DUT@label@englishkeywords} #1%
}

%% =================================================================
%% 重定义中英文目录命令
%% =================================================================
%% 中文目录：写入 toc，并生成 PDF 书签。
\renewcommand\tableofcontents{%
  \if@twocolumn% 如果是双栏排版
    \@restonecoltrue\onecolumn% 切换到单栏模式以生成目录，并使@restonecol标志为 true，以便后续恢复双栏模式
  \else
    \@restonecolfalse
  \fi
  \chapter*{\DUT@label@toc@title}% 章标题不编号，但显示“目录”
  \addcontentsline{toc}{chapter}{\contentsname}%将目录添加到 toc 中
  \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%%设置页眉左右两侧的文本为大写的“目录”，正文里好像没有显现
  \pdfbookmark[0]{\contentsname}{bittoc}
  \@starttoc{toc}% 从 toc 文件读取目录内容并生成目录
  \if@restonecol\twocolumn\fi
}

%% 英文目录标题文本
\def\engcontentsname{\DUT@label@contents@en}
\renewcommand\engcontentsname{\bf\zihao{-3} \hfill \DUT@label@contents@en \hfill}

%% 英文目录：从 toe 文件读取。
\newcommand\tableofengcontents{%好像不是很完整
  \@restonecolfalse
  \chapter*{%
    \engcontentsname
    \@mkboth{\engcontentsname}{\engcontentsname}%
  }
  \addcontentsline{toc}{chapter}{\DUT@label@contents@en}
  \@starttoc{toe}%
  \if@restonecol\twocolumn\fi
}

%% =================================================================
%% 重定义参考文献环境
%% =================================================================
\renewenvironment{thebibliography}[1]%%缩进好像不对
  {%
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
        \renewcommand\theenumiv{\@arabic\c@enumiv}%
      }%
    \sloppy%断行设置，允许在单词边界处断行，以避免过长的行导致溢出。
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m%让句号后的间距处理保持合适状态。
  }
  {%
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%防止参考文献列表为空时出现错误，改为发出警告。
    \endlist
  }

%% =================================================================
%% 后置部分：成果、项目、简历、结论、致谢、符号表
%% =================================================================
%% 科研成果环境：若当前页不是奇数页，则先补空白页，使新页位置符合模板习惯。
\newenvironment{publications}
  {%
    \ifodd\c@page
    \else
      \clearpage
      \phantom{s}
      \thispagestyle{empty}
    \fi
    \chapter*{\DUT@label@publications}
    \addcontentsline{toc}{chapter}{\DUT@label@publications}
    \addcontentsline{toe}{chapter}{\DUT@label@publications@en}
  }
  {}

%% 项目环境：样式类似参考文献列表。
\newenvironment{projects}[1]
  {%
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
        \renewcommand\theenumiv{\@arabic\c@enumiv}%
      }%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m
  }
  {%
    \def\@noitemerr{\@latex@warning{Empty `projects' environment}}%
    \endlist
  }

%% 作者简介环境
\newenvironment{resume}
  {%
    \ifodd\c@page
    \else
      \clearpage
      \phantom{s}
      \thispagestyle{empty}
    \fi
    \chapter*{\DUT@label@resume}
    \addcontentsline{toc}{chapter}{\DUT@label@resume}
    \addcontentsline{toe}{chapter}{\DUT@label@resume@en}
  }
  {}

%% 简历中的一级小节
\newenvironment{resumesection}[1]
  {%
    {\noindent\normalfont\bfseries #1}%
    \list{}{\labelwidth\z@ \leftmargin 2\ccwd}%
    \item\relax
  }
  {\endlist}

%% 简历中的缩进列表项
\newenvironment{resumeli}[1]
  {%
    {\noindent\normalfont\bfseries #1}%
    \list{}{%
      \labelwidth\z@
      \leftmargin 4\ccwd
      \itemindent -2\ccwd
      \listparindent\itemindent
    }%
    \item\relax
  }
  {\endlist}

%% 结论环境：无编号章节，但加入目录。
\newenvironment{conclusion}
  {%
    \chapter*{\DUT@label@conclusion}
    \@mkboth{\DUT@label@conclusion}{\DUT@label@conclusion}%
    \addcontentsline{toc}{chapter}{\DUT@label@conclusion}
  }
  {}

%% 致谢环境
\renewenvironment{thanks}
  {%
    \ifodd\c@page
    \else
      \clearpage
      \phantom{s}
      \thispagestyle{empty}
    \fi
    \chapter*{\DUT@label@thanks@title}
    \addcontentsline{toc}{chapter}{\DUT@label@thanks}
    \addcontentsline{toe}{chapter}{\DUT@label@thanks@en}
  }
  {}

%% 符号说明环境：依赖前文定义的 \DUT@label@symbolnote。
\newenvironment{symbolnote}
  {%
    \chapter{\DUT@label@symbolnote}
    \fangsong
  }
  {}

%% 主要符号表环境
\newenvironment{denotation}
  {\chapter{\DUT@label@denotation}}
  {}

%% =================================================================
%% 化学式、国际单位与计数器深度设置
%% =================================================================

%% 章节编号深度与目录显示深度
\setcounter{secnumdepth}{4}  %% 章节编号的深度细到 subsubsection
\setcounter{tocdepth}{2}     %% 目录显示到 subsection

\endinput
%%
%% End of file `dutmaster-xetex.cls'.




