**About the project**
-

*GAIA* is an open-source web-based POS (Point-of-Sale) system integrated with an algorithm to identify and evaluate system latency and desynchronization. The system is web-based and will be implemented in a webhost service. 

The system is built with both the [Julia](https://julialang.org) programming language for the data analytics and C# with the ASP.NET and MVC for the website. The information system will have the following features:

- [x] Client-friendly dashboard for easy integration from common POS systems
- [x] Latency identifier on Admin Dashboard to evaluate system degredation
- [x] Outputs visual and interpretable plots for systems analysis


**Technical Description**
-
*The Problem*

The POS uses two main languages, the Julia programming language and C#. The system introduces two different algorithms for determining a common problem within POS systems, escpecially during heavy loads. These problems are:
- Transaction Latency (Defined as _L_ = Server Processing Time - Client Initiation Time); and
- Client-Server Desynchronization

*The Solution?*

First, we need to identify when does latency come about at the start of the transaction and after it. We propose that a way to find these latencies during the transaction will be evaluated by taking the _innovation_ (symbolized as $\nu$), that is, the difference between the actual measurement and the measurement predicted by the filter's state estimate. After taking it, we standardized it by taking its variance $Var(\nu) = S$, taking its square root ($\sqrt{S}$) and dividing the innovation with it, thus $r_t = \frac{\nu}{\sqrt{S}}$. We give meaning to this variable by interpreting $r_t$ as the standardized (aka Z-score) value of the innovations at time t.

**Usage** 
-

At this current moment, the software is still under development and no available *Release* versions have been published as of late. Therefore no usage instructions will be provided at the moment. 
;)


**Notice**
-

This program is built in assistance of a GenAI but it did not contribute directly, and no part of the program/webapp uses any GenAI of sort as part of the system or the features thereof.

**Made with :heart: by**
-

- [@Yuto](https://github.com/YuleTomalin) (Head Developer, Repository Manager)
- [@Juuri-hue](https://github.com/Juuri-hue) (Head Website Developer)

**License**
-

[MIT License]()