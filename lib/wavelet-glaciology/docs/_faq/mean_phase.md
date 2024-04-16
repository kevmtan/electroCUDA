---
layout: page
title: How do I calculate the average phase angle?
categories: faq
---

You can use anglemean.m provided with the package. Here is a small example that calculates the mean angle at the period closest to 11:

```matlab
t=(0:1:500)';
X=sin(t*2*pi/11)+randn(size(t))*.1;
Y=sin(t*2*pi/11+.4)+randn(size(t))*.1;
[Wxy,period,scale,coi,sig95]=xwt([t X],[t Y]);
[mn,rowix]=min(abs(period-11)); %row with period closest to 11.
ChosenPeriod=period(rowix)
[meantheta,anglestrength,sigma]=anglemean(angle(Wxy(rowix,:)))
```


```
ChosenPeriod =
       11.032
meantheta =
     -0.40052
anglestrength =
      0.99973
sigma =
     0.023103

```

If you want to restrict the mean to be calculated over significant regions outside the COI then you can do like this:

```matlab
incoi=(period(:)*(1./coi)>1);
issig=(sig95>=1);
angles=angle(Wxy(rowix,issig(rowix,:)&~incoi(rowix,:)));
[meantheta,anglestrength,sigma]=anglemean(angles)
```


```
meantheta =
     -0.39953
anglestrength =
      0.99978
sigma =
     0.020992

```

