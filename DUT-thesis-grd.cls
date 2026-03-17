%==================================================
%% DUT-thesis-grd.cls for DUT Thesis
%% version: 2.0
%% last update: Apr 27th, 2026
%%==================================================

%% =================================================================
%% 本文提供可调用函数：
%% =================================================================

%% =================================================================
%% 预备修改内容：改了哪些部分要明确输出给我看。
%% 1、将所有固定文本改为可覆盖的变量，按照固定表头为label，表头后可修改的为value，并提供接口函数供主文件调用。
%% 2、函数接口命名规范化，统一使用英文单词，避免中文拼音缩写。
%% 3、在每行代码后面增加注释说明，明确每个函数的作用、参数含义以及使用方法。
%% 4、将整个文件的结构顺序和重新调整，符合标准的 LaTeX 类文件编写规范，增强可读性和维护性。
%% 5、在本文最前面注释区，总结所有本文定义的函数，以及重定义的函数，并按照功能分类进行说明，方便用户查阅和使用。
%% =================================================================


%% =================================================================
%% 引用宏包
%% =================================================================
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm,mathrsfs}%% 这一组宏包提供公式、定理、符号、粗体数学符号等基础能力。可能与 xunicode 存在兼容性注意事项，因此集中放在文件开头。
\RequirePackage{upgreek}  %% 提供直立希腊字母，例如 \upalpha、\upbeta
\RequirePackage{xstring}  %% 提供字符串长度计算
\RequirePackage{forloop}  %% 提供循环输出功能
\RequirePackage{ulem}    %% 提供下划线等文本强调命令
\RequirePackage{tikz}
\RequirePackage{etoolbox}
\RequirePackage{pifont}
\RequirePackage{setspace}
%%原文有个\usepackage{titlesec}暂时不懂要不要放在这

%% =================================================================
%% LaTeX 类文件基础声明
%% =================================================================
%% 指定最低 LaTeX 内核版本要求
\NeedsTeXFormat{LaTeX2e}[2005/12/01]

%% 声明当前类文件名称与版本信息
\ProvidesClass{DUT-thesis-grd}[2026/04/27 v2.0 DUT-thesis-grd document class]

%% =================================================================
%% 类选项：把未知选项转交给底层的 ctexbook
%% =================================================================
%% 这样主文件里传入的通用选项（如字号、纸张等）仍可由 ctexbook 处理
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}

%% =================================================================
%% 创建布尔变量：学位_单双面排版_是否隐藏姓名
%% =================================================================

\newif\ifDUT@twoside%% \ifDUT@twoside：是否启用双面排版
\DUT@twosidefalse
\newif\ifDUT@Hidden   %% \ifDUT@Hidden   ：是否启用隐藏功能
\DUT@Hiddenfalse

%% 等待\documentclass传入选项后再处理
\DeclareOption{twoside}{\DUT@twosidetrue}
\DeclareOption{oneside}{\DUT@twosidefalse}
\DeclareOption{hide}{\DUT@Hiddentrue}
\DeclareOption{nohide}{\DUT@Hiddenfalse}

%% 处理以上所有选项
\ProcessOptions\relax

%% =================================================================
%% 加载底层文档类 ctexbook
%% =================================================================
%% 双面模式：章通常从右页开始（openright）
%% 单面模式：章可从任意页开始（openany）
\ifDUT@twoside
  \LoadClass[zihao=-4,a4paper,twoside,openright,UTF8,space=auto]{ctexbook}
\else
  \LoadClass[zihao=-4,a4paper,oneside,openany,UTF8,space=auto]{ctexbook}
\fi

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

%% =================================================================
%% ctex 宏的重定义：目录、图目录、表目录标题
%% =================================================================
\renewcommand\contentsname{目　　录}
\renewcommand\listfigurename{图~目~录}
\renewcommand\listtablename{表~目~录}

%% =================================================================
%% DUT宏定义：中文封面与学位信息（固定值）
%% =================================================================
\def\DUT@label@major{学科、~~专业:}
\def\DUT@label@title{论文题目}
\def\DUT@label@author{作~~者~~姓~~名:}
\def\DUT@label@classification{中图分类号：}
\def\DUT@label@confidential{密级}
\def\DUT@label@UDC{UDC\!分类号：}
\def\DUT@label@serialnumber{编号}
\def\DUT@label@thesis{学位论文}
\def\DUT@label@advisor{指~~导~~教~~师:}
\def\DUT@label@degree{申~~~~请~~~~学~~~~位}
\def\DUT@label@submitdate{论文提交日期}
\def\DUT@label@defenddate{答~~辩~~日~~期:}
\def\DUT@label@studentnumber{学~~~~~~~~~~~~~~号:}
\def\DUT@label@institute{学~~~~院~~~~名~~~~称}
\def\DUT@label@school{学~位~授~予~单~位}
\def\DUT@label@chairman{答辩委员会主席}

%% =================================================================
%% DUT宏定义：中文封面与学位信息（缺省值，可覆盖）
%% =================================================================
\def\DUT@value@classification{}
\def\DUT@value@confidential{}
\def\DUT@value@UDC{}
\def\DUT@value@serialnumber{}
\def\DUT@value@school{}
\def\DUT@value@degree{}
\def\DUT@value@title{~~~~~（论~文~题~目）~~~~~}
\def\DUT@value@vtitle{竖排论文题目}
\def\DUT@value@titlemark{\DUT@value@title}
\def\DUT@value@author{（作~者~姓~名）}
\def\DUT@value@advisor{（姓名、专业技术职务、学位）}
\def\DUT@value@advisorinstitute{（单位）}
\def\DUT@value@major{}
\def\DUT@value@studentnumber{}
\def\DUT@value@submitdate{}
\def\DUT@value@defenddate{}
\def\DUT@value@institute{}
\def\DUT@value@chairman{}
\def\DUT@label@statement{}

%% =================================================================
%% DUT宏定义：原创性声明、版权授权、答辩委员会（固定值）
%% =================================================================
\def\DUT@label@original{学位论文原创性申明}
\def\DUT@label@committeemembers{硕士学位论文答辩委员会}
\def\DUT@label@authorization{大连理工大学学位论文版权使用授权书}
\def\DUT@label@authorsign{作~~者~~签~~名~~：}
\def\DUT@label@Supervisorsign{导~~师~~签~~名~~：}
\def\DUT@label@originalDate{日期：}
\def\DUT@label@originaltitle{学位论文题目：}

%% =================================================================
%% DUT宏定义：答辩委员会与答辩安排（缺省值，可覆盖）
%% =================================================================
\def\DUT@value@titleone{}
\def\DUT@value@titletwo{}
\def\DUT@value@titlethree{}
\def\DUT@value@titlefour{}
\def\DUT@value@titlefive{}
\def\DUT@value@profone{}
\def\DUT@value@proftwo{}
\def\DUT@value@profthree{}
\def\DUT@value@proffour{}
\def\DUT@value@proffive{}
\def\DUT@value@dabianren{}%%待改名字为英文单词
\def\DUT@value@shijian{}%%待改名字为英文单词
\def\DUT@value@where{}%%待改名字为英文单词

%% =================================================================
%% 主文件接口：供用户填写答辩委员会与答辩信息
%% =================================================================
\newcommand\titleone[1]{\def\DUT@value@titleone{#1}}
\newcommand\titletwo[1]{\def\DUT@value@titletwo{#1}}
\newcommand\titlethree[1]{\def\DUT@value@titlethree{#1}}
\newcommand\titlefour[1]{\def\DUT@value@titlefour{#1}}
\newcommand\titlefive[1]{\def\DUT@value@titlefive{#1}}
\newcommand\profone[1]{\def\DUT@value@profone{#1}}
\newcommand\proftwo[1]{\def\DUT@value@proftwo{#1}}
\newcommand\profthree[1]{\def\DUT@value@profthree{#1}}
\newcommand\proffour[1]{\def\DUT@value@proffour{#1}}
\newcommand\proffive[1]{\def\DUT@value@proffive{#1}}
\newcommand\dabianren[1]{\def\DUT@value@dabianren{#1}}
\newcommand\shijian[1]{\def\DUT@value@shijian{#1}}
\newcommand\where[1]{\def\DUT@value@where{#1}}

%% =================================================================
%% DUT宏定义：声明页正文常量
%% =================================================================
\def\DUT@label@originalchairman{答辩委员会主席：}%在哪里用过？？？？？？？？？？
\def\DUT@label@originalcontent{\DUTspace\DUTspace 本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经指明引用的内容外，学位论文不含任何其他个人、法人或者非法人组织已经发表或尚未发表的作品，且学位论文中已经指明作者姓名或者名称、作品名称的内容，不影响该作品的正常使用，也不存在不合理地损害相关权利人的合法权益的任何情形。对学位论文研究做出重要贡献的个人和法人或者非法人组织，均已在论文中以明确方式标明，且不存在任何著作权纠纷。\par 若因声明不实，本人愿意为此承当相应的法律责任。}
\def\DUT@label@authorizationcontent{\DUTspace\DUTspace 本人完全了解大连理工大学有关学位论文知识产权的规定，在校攻读学位期间论文工作的知识产权属于大连理工大学，允许论文被查阅和借阅。学校有权保留论文并向国家有关部门或机构送交论文的复印件和电子版，可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印、或扫描等复制手段保存和汇编本学位论文。}

%% =================================================================
%% DUT宏定义：论文固定章节标题与模板版本信息
%% =================================================================
\def\DUT@label@abstract{摘要}
\def\DUT@label@keywords{关键词：}
\def\DUT@label@englishkeywords{Key Words:~}
\def\DUT@label@conclusion{结论}
\def\DUT@label@appendix{附录}
\def\DUT@label@publications{攻读硕士学位期间科研项目及科研成果}
\def\DUT@label@projects{攻读学位期间参与的项目}
\def\DUT@label@resume{作者简介}
\def\DUT@label@reference{参考文献!!!!}
\def\DUT@label@thanks{致谢}
\def\DUT@value@templateversion{v2.0}

%% =================================================================
%% DUT宏定义：页眉页脚中使用的固定学校名称
%% =================================================================
\def\DUT@label@headschoolname{大连理工大学硕士学位论文}

%% 当前模板版本输出函数：\version
\newcommand{\version}{\DUT@value@templateversion}

%% =================================================================
%% 版面设置与基础排版控制
%% =================================================================
%% 使用 geometry 统一设置纸张尺寸与版芯。
%% 当前模板采用 A4 纸，边距参数为：
%% 上 3.5 cm，下 2.5 cm，左/右 2.7 cm，页眉高度 0.5 cm，页脚间距 1.47 cm。
\usepackage[
  paper=a4paper,
  top=3.5cm,
  bottom=2.5cm,
  left=2.7cm,
  right=2.7cm,
  headheight=0.50cm,
  footskip=1.47cm
]{geometry}

% %% 在双面模式下，重定义 \cleardoublepage：？？？？？？？？？？？？？？？？？？没懂
% %% 如果当前页是偶数页，则插入一个真正的空白页，并取消页眉页脚。
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

%% 设置全局1.35倍行距。
\setstretch{1.35}
%% =================================================================
%% 标题层级格式（章/节/小节/小小节）
%% =================================================================
%% 使用 ctexset 统一设置 chapter/section/subsection/subsubsection 的字号、字体、编号与上下间距。
\ctexset{chapter={
  name = {},
  number = {\arabic{chapter}},
  format = {\CTEXifname{\raggedright\heiti\zihao{3}}{\centering\heiti\zihao{-3}}},
  pagestyle = {DUT@headings},
  beforeskip = 12bp,
  afterskip  = 28bp,
  fixskip    = true,
}}

\ctexset{section={
  format     = {\heiti\zihao{4}},
  beforeskip = 12bp,
  afterskip  = 8bp,
  fixskip    = true,
}}

\ctexset{subsection={
  format     = {\raggedright\heiti\zihao{-4}},
  beforeskip = 8bp,
  afterskip  = 6bp,
  fixskip    = true,
}}
\usepackage{titlesec}%% 加载 titlesec 并定义三级标题格式。？？？？？？？这能放在这吗
\ctexset{subsubsection={
  name       = {(,)},
  number     = {\arabic{subsubsection}},
  format     = {\raggedright\heiti\zihao{-4}},
  beforeskip = 8bp,
  afterskip  = 6bp,
  fixskip    = true,
}}

%% =================================================================
%% 目录、图目录、表目录的书签与排版样式
%% =================================================================
%% 进入目录相关文件时临时关闭超链接边框显示，避免目录中出现彩色方框。
\addtocontents{toc}{\protect\hypersetup{hidelinks}}%目录
\addtocontents{toe}{\protect\hypersetup{hidelinks}}%英文目录
\addtocontents{lot}{\protect\hypersetup{hidelinks}}%表目录
\addtocontents{lof}{\protect\hypersetup{hidelinks}}%图目录

\RequirePackage{titletoc}%%目录样式宏包？？？？？？？？？？？这个宏包为什么不能放在文件开头
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

%% =================================================================
%% 编译模式判断与页眉页脚控制
%% =================================================================
\RequirePackage{ifthen}   %% 提供条件判断命令
\RequirePackage{ifpdf}    %% 判断当前是否为 PDF 输出模式（保留原模板依赖）
\RequirePackage{fancyhdr} %% 页眉页脚样式控制

%% 定义 DUT@empty 样式：完全清空页眉页脚内容
\fancypagestyle{DUT@empty}{
  \fancyhf{}
}

%% 定义 DUT@headings 样式：居中显示文字页眉、页码页脚
\fancypagestyle{DUT@headings}{
  \fancyhf{}
  \fancyfoot[C]{\songti\zihao{5} \thepage}  %%页脚中部显示页码
  \fancyhead[CO]{\zihao{5}{\songti 大连理工大学硕士学位论文}}%%？？？？？？？？？？？？？应改为主文件输入
  \fancyhead[CE]{\zihao{5}{\songti 大连理工大学硕士学位论文格式规范}}
}

%% =================================================================
%% 处理 openright 产生的空白页
%% =================================================================
%% 目标：双面模式下章节右开时，若自动插入空白页，则该页不显示页眉页脚。

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

%% =================================================================
%% frontmatter / mainmatter 页码与页眉页脚风格
%% =================================================================
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

%% =================================================================
%% 表格扩展与数学常量、定理环境
%% =================================================================
\RequirePackage{threeparttable} %% 三线表注释环境
\RequirePackage{dcolumn}        %% 小数点对齐列类型
\RequirePackage{multirow}       %% 多行单元格
\RequirePackage{booktabs}       %% 更美观的横线命令

%% d 列：按小数点对齐，例如 \begin{tabular}{d{2.3}}
\newcolumntype{d}[1]{D{.}{.}{#1}}

%% 常用数学常量：直立体 e、i、j 以及微分符号 d
\newcommand{\me}{\mathrm{e}}
\newcommand{\mi}{\mathrm{i}}
\newcommand{\mj}{\mathrm{j}}
\newcommand{\dif}{\,\mathrm{d}}

%% 定理类环境：按 chapter 编号
\theoremstyle{definition}
\newtheorem{algo}{算法~}[chapter]
\newtheorem{thm}{定理~}[chapter]
\newtheorem{lem}[thm]{引理~}
\newtheorem{prop}[thm]{命题~}
\newtheorem{cor}[thm]{推论~}

\theoremstyle{definition}
\newtheorem{defn}{定义~}[chapter]
\newtheorem{conj}{猜想~}[chapter]
\newtheorem{exmp}{例~}[chapter]
\newtheorem{rem}{注~}
\newtheorem{case}{情形~}

%% proof 环境标题改为中文“证明”
\renewcommand{\proofname}{\bf 证明}

%% =================================================================
%% 英文字体设置
%% =================================================================
\RequirePackage{xltxtra} %% XeLaTeX 扩展，提供字体相关支持
\setmainfont{Times New Roman}%% 设置正文字体为 Times New Roman
\setsansfont{Arial}%% 设置无衬线字体为 Arial
\setmonofont{Courier New}%% 设置等宽字体为 Courier New

%% =================================================================
%% 图片、表格、双语标题与图表题注设置
%% =================================================================
\RequirePackage{graphicx}   %% 图形插入
\RequirePackage{subfigure}  %% 并列子图（保留原模板写法）
\RequirePackage{makecell}   %% 表格单元格内换行
\RequirePackage{wrapfig}    %% 文字环绕图片

%% 以下若干宏包与设置用于控制图表标题样式。
%% 注意：原模板存在重复加载 amsmath / caption / booktabs 的情况；
%% 为尽量保持原始行为，这里仍然保留这些调用，只做排版与注释整理。
\RequirePackage{amsmath}
\RequirePackage{caption}
\usepackage[list=off]{bicaption}
\usepackage[justification=centering]{caption}
\usepackage{booktabs}
\RequirePackage{tabularx}

%% 图表标题：中文标题与编号间使用一个汉字宽度的间距。
\DeclareCaptionLabelSeparator{f_t_caption_space}{\hspace{1\ccwd}}%%定义一个汉字宽度的空白。
\DeclareCaptionFont{f_t_caption_font}{\songti\zihao{5}}%%定义caption 字体。
\captionsetup{%%？？？？？？？？？？？？？？？和后面好像可以合并写
  font     = {f_t_caption_font},
  labelsep = f_t_caption_space,
}

%% 图的英文第二标题名称
\captionsetup[figure][bi-second]{name=Fig.}
%% 表的英文第二标题名称
\captionsetup[table][bi-second]{name=Tab.}

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
\RequirePackage[numbers,square,comma,sort&compress]{natbib}

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
\RequirePackage{xcolor} %% 颜色支持
\usepackage{float}      %% 提供 [H] 强制浮动位置

%% 中文破折号：通过规则线手工绘制
\newcommand{\cndash}{%
  \rule{0.0em}{0pt}\rule[0.35em]{1.4em}{0.05em}\rule{0.2em}{0pt}%
}

%% listings：源码显示环境
\RequirePackage{listings}
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
  numbersep          = -1em,
}

%% listings 标题名称改为“代码”
\renewcommand{\lstlistingname}{代码}

%% 算法环境：编号按 chapter 计数
\newcounter{algorithm}[chapter]
\usepackage{algorithm}%% 算法浮动体环境
\usepackage{algorithmicx}%%算法排版宏包
\usepackage{algpseudocode}%%伪代码风格宏包
\renewcommand{\algorithmicrequire}{\textbf{Input:}}%%输入使用input替换require，输出使用output替换ensure
\renewcommand{\algorithmicensure}{\textbf{Output:}}
\renewcommand\thealgorithm{\thechapter.\arabic{algorithm}}%%算法编号格式为“章号.序号”


%% hyperref package

\RequirePackage{hyperref}
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
\usepackage{enumitem}
\usepackage{supertabular}%% 允许跨页的表格环境，？？？？？该放在这吗
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
% \setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=0pt}
% \setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}

%% =================================================================
%% 参考文献风格与内部辅助命令
%% =================================================================
\bibliographystyle{GBT7714-2005NLang}%%？？？？？？？？？？？为何不用2015国标
\usepackage[numbers,sort&compress]{natbib} %% ？？？？？好像重复了，也使用了不该使用的usepackage关键字，保留原模板的再次加载写法

%% DUTspace：输出若干个汉字宽度的水平空白。
%% 例如 \DUTspace[2] 表示约两个汉字宽的空格。
\newcommand{\DUTspace}[1][1]{\hspace{#1\ccwd}}%%？？？？？？？？？感觉可以复用到图表标题

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
%% 定义中文标题页信息接口函数：供主文件填写封面字段
%% =================================================================
\newcommand\classification[1]{\def\DUT@value@classification{#1}}%分类号接口函数
\newcommand\studentnumber[1]{\def\DUT@value@studentnumber{#1}}%学号接口函数
\newcommand\confidential[1]{\def\DUT@value@confidential{#1}}%密级接口函数
\newcommand\UDC[1]{\def\DUT@value@UDC{#1}}%UDC接口函数
\newcommand\serialnumber[1]{\def\DUT@value@serialnumber{#1}}%序列号接口函数
\newcommand\school[1]{\def\DUT@value@school{#1}}%单位接口函数
\newcommand\degree[1]{\def\DUT@value@degree{#1}}%学位接口函数

%% 重定义\title函数，增加可选参数用于页眉/书签中的大写标题，默认取正文标题。
\renewcommand\title[2][\DUT@value@title]{%默认参数为 \DUT@value@title
  \def\DUT@value@title{#2}%
  \def\DUT@value@titlemark{\MakeUppercase{#1}}%？？？？？本行是否可以放到#2前
}

\newcommand\vtitle[1]{\def\DUT@value@vtitle{#1}}%竖排标题接口函数
\renewcommand\author[1]{\def\DUT@value@author{#1}}%作者姓名接口函数
\newcommand\advisor[1]{\def\DUT@value@advisor{#1}}%导师姓名接口函数
\newcommand\advisorinstitute[1]{\def\DUT@value@advisorinstitute{#1}}%导师单位接口函数
\newcommand\major[1]{\def\DUT@value@major{#1}}%专业接口函数
\newcommand\submitdate[1]{\def\DUT@value@submitdate{#1}}%提交日期接口函数
\newcommand\defenddate[1]{\def\DUT@value@defenddate{#1}}%答辩日期接口函数
\newcommand\institute[1]{\def\DUT@value@institute{#1}}%单位接口函数
\newcommand\chairman[1]{\def\DUT@value@chairman{#1}}%答辩委员会主席接口函数

%% =================================================================
%% 中文标题页绘制
%% =================================================================
%% 这里定义行楷字体族，并且简化了使用方式，例如 \xkai{大连理工大学} 就可以直接输出行楷字体的校名。
\setCJKfamilyfont{xkai}{STXingkai}
\newcommand{\xkai}{\CJKfamily{xkai}}

%% 重定义绘制中文标题页。
%% 注意：当前页面中的若干占位文字、签名图片路径等都沿用原模板写法。
\renewcommand\maketitle[1]{%
  \cleardoublepage
  \thispagestyle{empty}

  \begin{center}
    \vskip \stretch{1}%垂直方向上放可伸缩空白
    \def\tabcolsep{1pt}%调整表格的，好像没用上，难道在答辩委员会的地方用上了吗，这段语句生效到那个地方吗
    \def\arraystretch{1.5}%调整表格行高好像没用上

    \parbox[t][4.40cm][c]{\textwidth}{%
      \begin{center}
        {\songti\zihao{-1}\textsf{硕士学位论文}\\}%%？？？？？？？？？？？？这地方也得做成主文件可修改
        \vspace{1.34cm}
        {\heiti\zihao{2}\textsf{大连理工大学硕士学位论文格式规范}\\}%%？？？？？？？？？？？？这地方也得做成主文件可修改
        \vspace{0.13cm}
        {\zihao{3}\textbf{Format Criterion of Master Degree Thesis of DUT}\\}
      \end{center}
    }

    \vspace{50.2mm}

    {\songti\zihao{-3}\DUT@label@author}\DUTunderline[170pt]{\songti\zihao{-3}姓名}%%？？？？？？？？？？？？这地方也得做成主文件可修改
    \vskip 10pt
    {\songti\zihao{-3}\DUT@label@studentnumber}\DUTunderline[170pt]{\songti\zihao{-3}12345678}
    \vskip 10pt
    {\songti\zihao{-3}\DUT@label@advisor}\DUTunderline[170pt]{\songti\zihao{-3}导师}%%？？？？？？？？？？？？这地方也得做成主文件可修改
    \vskip 10pt
    {\songti\zihao{-3}\DUT@label@major}\DUTunderline[170pt]{\songti\zihao{-3}专业}
    \vskip 10pt
    {\songti\zihao{-3}\DUT@label@defenddate}\DUTunderline[170pt]{\songti\zihao{-3}2023年4月}
    \vskip 3pt
    \colorbox{yellow}{注：对于专业学位硕士,企业或实践导师必填,写法样例:XXX(企业导师)或XXX(实践导师)}%%等待修改
    \\ \vspace{31.4mm}
    {\Large\xkai 大连理工大学\\}
    \vspace{2.3mm}
    {\zihao{-4} Dalian University of Technology}
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
  \pdfbookmark[0]{声明}{statement}%pdf加书签“声明”，内部锚点为statement
  \thispagestyle{empty}%无页眉页脚

  \begin{center}
    \parbox[t][1.52cm][c]{\textwidth}
    {\heiti\zihao{-2}\centerline \DUT@label@original}%%声明标题
  \end{center}

  \vskip 10pt
  {\songti\zihao{-4}\DUT@label@originalcontent}%%声明内容
  \vskip 10pt
  {\songti\zihao{-4}\DUT@label@originaltitle}\DUTunderline[303pt]{填写自己的学位论文题目}%%又是不能在主文件修改的，要改
  \vskip 3pt
  \indent{\songti\zihao{-4}\DUT@label@authorsign}
  \DUTunderline[8em]{\includegraphics[height=0.8cm]{figures/figure2}}
  \hspace{1.3em}
  {\songti\zihao{-4}\DUT@label@originalDate}\DUTunderline[4em]{2023}~年~\DUTunderline[2em]{4}~月~\DUTunderline[2em]{7}~日~%%是不是也可以改成前面那种拆分字符串的形式，在主文件里面可改

  \vskip 20mm

  \begin{center}
    {\heiti\zihao{-2} \DUT@label@authorization}
  \end{center}

  \vskip 10pt
  {\songti\zihao{-4} \DUT@label@authorizationcontent}
  \vskip 25pt
  {\songti\zihao{-4}\DUT@label@originaltitle}\DUTunderline[303pt]{填写自己的学位论文题目}
  \vskip 3pt
  \indent{\songti\zihao{-4}\DUT@label@authorsign}
  \DUTunderline[10.65em]{\includegraphics[height=0.8cm]{figures/figure2}}
  {\songti\zihao{-4}\DUT@label@originalDate}\DUTunderline[3em]{2023}年~\DUTunderline[2em]{4}~月~\DUTunderline[2em]{7}~日~
  \vskip 3pt
  \indent{\songti\zihao{-4}\DUT@label@Supervisorsign}
  \DUTunderline[10.65em]{\includegraphics[height=0.8cm]{figures/figure1}}
  {\songti\zihao{-4}\DUT@label@originalDate}\DUTunderline[3em]{2023}~年~\DUTunderline[2em]{4}~月~\DUTunderline[2em]{7}~日~
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
  \pdfbookmark[0]{委员会}{council}
  \thispagestyle{empty}

  \begin{center}
    \parbox[t][1.52cm][c]{\textwidth}
    {\heiti\zihao{-2}\centerline \DUT@label@committeemembers}
  \end{center}

  \vskip 50pt
  {\songti\zihao{4} \noindent{答辩人:\DUT@value@dabianren}}%%答辩人也得改成lablel的形式
  \vskip 35pt
  {\songti\zihao{4} \noindent{答辩委员会委员:}}
  \vskip 25pt

  \begin{center}
    {\zihao{4}
      \begin{tabular}{rl}
        \DUT@value@titleone   & {\DUTunderline[150pt]{\DUT@value@profone}}\songti\zihao{5}（注:主席）\\[0.7cm]%%为什么这个地方要特地表明字体和字号
        \DUT@value@titletwo   & \DUTunderline[150pt]{\DUT@value@proftwo}\\[0.7cm]%%0.7cm行间距
        \DUT@value@titlethree & \DUTunderline[150pt]{\DUT@value@profthree}\\[0.7cm]
        \DUT@value@titlefour  & \DUTunderline[150pt]{\DUT@value@proffour}\\[0.7cm]
        \DUT@value@titlefive  & \DUTunderline[150pt]{\DUT@value@proffive}%%这种写法就对了，给接口到主文件中进行修改，但是\DUT@value@titlefive这种还是要改成\DUT@value@labelfive这种
      \end{tabular}}
  \end{center}

  \vskip 40pt
  {\songti\zihao{4} \noindent{答辩日期:~\DUT@value@shijian}}
  \vskip 15pt
  {\songti\zihao{4} \noindent{答辩地点:\DUT@value@where}}

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
    \chapter{ABSTRACT}
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
  \chapter*{\contentsname}% 章标题不编号，但显示“目录”
  \addcontentsline{toc}{chapter}{目录}%将目录添加到 toc 中，作为 chapter 级别的条目，显示文本为“目录”
  \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%%设置页眉左右两侧的文本为大写的“目录”，正文里好像没有显现
  \pdfbookmark[0]{目录}{bittoc}
  \@starttoc{toc}% 从 toc 文件读取目录内容并生成目录
  \if@restonecol\twocolumn\fi
}

%% 英文目录标题文本
\def\engcontentsname{CONTENTS}%这地方没有使用变量，并且好像与下一行有些重复
\renewcommand\engcontentsname{\bf\zihao{-3} \hfill TABLE OF CONTENTS \hfill}

%% 英文目录：从 toe 文件读取。
\newcommand\tableofengcontents{%好像不是很完整
  \@restonecolfalse
  \chapter*{%
    \engcontentsname
    \@mkboth{\engcontentsname}{\engcontentsname}%
  }
  \addcontentsline{toc}{chapter}{TABLE OF CONTENTS}
  \@starttoc{toe}%
  \if@restonecol\twocolumn\fi
}

%% =================================================================
%% 重定义参考文献环境
%% =================================================================
\renewenvironment{thebibliography}[1]%%缩进好像不对
  {%
    \songti\zihao{5}
    \chapter*{参~~考~~文~~献}
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \addcontentsline{toc}{chapter}{参考文献}
    \addcontentsline{toe}{chapter}{References}
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
    \chapter*{攻读硕士学位期间科研项目及科研成果}%要改成变量形式
    \addcontentsline{toc}{chapter}{攻读硕士学位期间科研项目及科研成果}
    \addcontentsline{toe}{chapter}{Achievements}
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
    \chapter*{作者简介}
    \addcontentsline{toc}{chapter}{作者简介}
    \addcontentsline{toe}{chapter}{CV}
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
    \chapter*{结论}
    \@mkboth{结论}{结论}%
    \addcontentsline{toc}{chapter}{结论}
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
    \chapter*{致~~~~~~谢}
    \addcontentsline{toc}{chapter}{致谢}
    \addcontentsline{toe}{chapter}{Acknowledgements}
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
  {\chapter{主要符号表}}
  {}

%% =================================================================
%% 化学式、国际单位与计数器深度设置
%% =================================================================
\RequirePackage[version=4]{mhchem} %% 化学式，如 \ce{H2O}
\RequirePackage{siunitx}           %% 国际单位制，如 \SI{10}{\metre}

%% 章节编号深度与目录显示深度
\setcounter{secnumdepth}{4}  %% 章节编号的深度细到 subsubsection
\setcounter{tocdepth}{2}     %% 目录显示到 subsection

\endinput
%%
%% End of file `dutmaster-xetex.cls'.
