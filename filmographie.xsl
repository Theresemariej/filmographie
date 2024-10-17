<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>



<xsl:template match="/">
<html><head><link rel="stylesheet" type="text/css" href="film.css" />
 <title> cinématographie </title> 

 <script src ="https://code.jquery.com/jquery-2.2.4.min.js" > </script>
<script src="scroll.js"> </script>
<link rel="stylesheet" type="text/javascript" href="scroll.min.js" />
</head>
<body>
<div id="main">
    <section>
        <h1>Table des matières des films:</h1>
        <ul><xsl:apply-templates select="films/film" mode="tdm"/></ul>
    </section>
    <section>
        <h1>Table des matières des acteurs:</h1>
        <xsl:apply-templates select="films/acteurDescription"/>
        <br/>
    </section>
    <section>
    <h1>Cinématographie:</h1>
        <xsl:apply-templates select="films/film" mode="complet" >
           <xsl:sort select="@annee" order="descending" data-type="number" />
        </xsl:apply-templates>
    </section>
    <!--infèrieur à 2005 <xsl:apply-templates select="films/film[@annee &lt; 2005]" />-->
</div>

<script>
    $("#main").onepage_scroll({
        sectionContainer: "section",
        easing: "ease",
        animationTime: 1000,
        pagination: true,
        updateURL: false,
        beforeMove: function(index) {},
        afterMove: function(index) {},
        loop: false,
        keyboard: true,
        responsiveFallback: false
        });
</script>
</body>
</html>
</xsl:template>

<xsl:template match="film" mode="complet">
    <br/>
    <img src="{image/@ref}" class="image" alt="Image de {nom}" />
    <br/><br/>
    <h2>
    <xsl:if test="@annee=2005"> 
    <p class="couleur">nouveauté</p>
    </xsl:if>

    <a> <xsl:attribute name="name"><xsl:value-of select="nom"/></xsl:attribute>
    <xsl:value-of select="nom" />
    </a>
    <!--<xsl:text> </xsl:text> pour mettre un espace-->
    </h2>
    <ul class="puce"><xsl:apply-templates select="genres/genre"/></ul>
     <em>film <xsl:value-of select="nationalite" />
     de <xsl:value-of select="duree" /> minutes,
     sorti en <xsl:value-of select="@annee" /></em>
     <br/>
     *réalisé par <xsl:value-of select="realisateur" />*
     <br/>
     <ul><xsl:apply-templates select="acteurs/acteur" /></ul>
     <p class="histoireStyle"><xsl:apply-templates select="scenario" /></p>
</xsl:template>


<xsl:template match="film" mode="tdm">
    <li>
    <a>
    <xsl:attribute name="href">#<xsl:value-of select="nom" /></xsl:attribute>
    <xsl:value-of select="nom" />
    </a>
    (<xsl:value-of select="count(acteurs/acteur)"/>
    acteurs)
    [<xsl:apply-templates select="scenario/keyword"/>]
    </li>
</xsl:template>


<xsl:template match="acteur">
<li><xsl:value-of select="." /></li>
</xsl:template>

<xsl:template match="acteurDescription">
    <xsl:text> </xsl:text>
    <xsl:value-of select="prenom" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="nom" /> est né le 
    <xsl:value-of select="dateNaissance" />
    et a joué dans 
    <xsl:value-of select="count(/films/film[acteurs/acteur[@ref=current()/@id]])"/>
    film:
    <xsl:apply-templates select="/films/film[acteurs/acteur[@ref=current()/@id]]" mode="filmActeur"/>
    <br/>
</xsl:template>

<xsl:template match="film" mode="filmActeur"> 
    <xsl:text> </xsl:text>
    <a>
    <xsl:attribute name="href">#<xsl:value-of select="nom" /></xsl:attribute>
    <xsl:value-of select="position()" />
    </a>
</xsl:template>


<xsl:template match="scenario/personnage">
<strong><xsl:value-of select="." /></strong>
</xsl:template>


<xsl:template match="scenario/ev">
<em><xsl:value-of select="." /></em>
</xsl:template>

<xsl:template match="genre">
<li><xsl:value-of select="." /></li>
</xsl:template>

<xsl:template match="keyword">
<xsl:value-of select="." />
<xsl:text> </xsl:text>
</xsl:template>

</xsl:stylesheet>
