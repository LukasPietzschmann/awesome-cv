\RequirePackage{etoolbox}
\appto\input@path{{smile}}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{awesomecv}[]

\LoadClass[11pt]{article}

\RequirePackage[
	hmargin=2.3cm,
	vmargin=2cm,
	includefoot,
]{geometry}
\RequirePackage{microtype}
\RequirePackage{parskip}
\RequirePackage{setspace}
\RequirePackage[sfdefault]{josefin}
\RequirePackage[default,medium,bold,scale=.9]{raleway}
\RequirePackage{fontawesome5}
\RequirePackage{enumitem}
\RequirePackage[calcwidth]{titlesec}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[
	tikz,
]{smile}

\smile@linewidth2px
\smile@rounding1.5mm

\setlist[itemize]{
	leftmargin=*,
	itemsep=-.5\parsep,
	topsep=-.5\parsep,
	beginpenalty=10000,
	endpenalty=0,
	midpenalty=10000,
}

\titleformat{\section}{\itshape\bfseries\large}{}{}{\bigskip\josefinmedium\MakeUppercase}[{\color{accent!20!white}\hrule height \smile@linewidth depth \z@ width \titlewidth\relax}]

\newcommand\cv@infocard[2][]{\begin{tikzpicture}[node distance=1ex]
	\node (T) {#2};
	\if\relax\detokenize{#1}\relax
		\coordinate (S) at (T);
	\else
		\node[roundnode,draw=none,fill=accent!2,left=of T] (S) {\color{accent}#1};
	\fi
	\node[roundednode,shadow,minimum height=2.2\ht\strutbox,draw=none,fill=accent!10,fit=(S)(T),node on layer=background] {};
\end{tikzpicture}}

\newenvironment{infos}{
	\newcommand\info[2][]{\cv@infocard[##1]{##2}}
	\def\tel##1{\info[\faPhone]{##1}}
	\def\mail##1{\info[\faEnvelope]{\href{mailto:##1}{##1}}}
	\def\github##1{\info[\faGithub]{\href{https://github.com/##1}{##1}}}
	\def\linkedin##1{\info[\faLinkedin]{\href{https://www.linkedin.com/in/##1}{##1}}}
	\def\address##1{\info[\faMapMarker*]{##1}}
	\def\website##1{\info[\faGlobe]{\href{https://##1}{##1}}}
}{}

\newenvironment{skills}{
	\section*{Skills}
	\def\skill##1{\cv@infocard{##1}}
}{}

\newenvironment{education}{
	\section*{Education}
	\def\entry##1##2##3##4{
		{\bfseries##1\hfill\normalsize\normalfont\textcolor{darkgray}{##3}}\\
		\textcolor{accent}{##2}\\
		##4\par\bigskip
	}
}{}

\newenvironment{experience}{
	\section*{Experience}
	\newenvironment{entry}[3]{% Was, wo, wann
		{\bfseries##1\hfill\normalsize\normalfont\textcolor{darkgray}{##3}}\\
		\textcolor{accent}{##2}\par
		\itemize
	}{\enditemize\bigskip}
}{}

\newenvironment{publications}{
	\section*{Publications}
	\def\entry##1{\fullcite{##1}}
}{}

\def\pic#1{\def\@pic{#1}\def\@picwidth{2.5cm}}
\def\picwidth#1{\def\@picwidth{#1}}

\def\maketitle{
	\begin{minipage}[b][\@picwidth][c]{\dimexpr\textwidth-\@picwidth\relax}%
		\Huge\bfseries\@author%
	\end{minipage}%
	\begin{minipage}[b][\@picwidth][c]{\@picwidth}%
		\begin{tikzpicture}
			\begin{scope}
				\clip[rnd] (0,0) rectangle coordinate (centerpoint) ++ (\@picwidth,\@picwidth);
				\node[inner sep=\z@,outer sep=\z@] at (centerpoint) {\includegraphics[width=\@picwidth]{\@pic}};
			\end{scope}
		\end{tikzpicture}%
	\end{minipage}\vspace{1cm}%
}
