
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>


<xsl:template match="/">
<html><head><link rel="stylesheet" type="text/css" href="film.css" />
 <title> cinématographie </title> </head>
<body>
    <h1>Table des matières des films</h1>
    <ul><xsl:apply-templates select="films/film" mode="tdm"/></ul>

    <h1>Table des matières des acteurs</h1>
    <xsl:apply-templates select="films/acteurDescription"/>


    <h1>Cinématographie</h1>
    <xsl:apply-templates select="films/film" mode="complet" >
        <xsl:sort select="@annee" order="descending" data-type="number" />
    </xsl:apply-templates>
    <!--infèrieur à 2005 <xsl:apply-templates select="films/film[@annee &lt; 2005]" />-->
</body>
</html>
</xsl:template>

<xsl:template match="film" mode="complet">

    <h2>
    <xsl:if test="@annee=2005"> 
    <p class="couleur">nouveauté</p>
    </xsl:if>

    <a> <xsl:attribute name="name"><xsl:value-of select="nom"/></xsl:attribute>
    <xsl:value-of select="nom" />
    </a>
    <!--<xsl:text> </xsl:text> pour mettre un espace-->
    </h2>

     <em>film <xsl:value-of select="nationalite" />
     de <xsl:value-of select="duree" /> minutes,
     sorti en <xsl:value-of select="@annee" /></em>
     <br/>
     *réalisé par <xsl:value-of select="realisateur" />*
     <br/>
     <ul><xsl:apply-templates select="acteurs/acteur" /></ul>
     <br/>
     <p class="histoireStyle"><xsl:value-of select="scenario" /></p>
</xsl:template>


<xsl:template match="film" mode="tdm">
    <li>
    <a>
    <xsl:attribute name="href">#<xsl:value-of select="nom" /></xsl:attribute>
    <xsl:value-of select="nom" />
    </a>
    (<xsl:value-of select="count(acteurs/acteur)"/>
    acteurs)
    </li>
</xsl:template>


<xsl:template match="acteur">
<li><xsl:value-of select="." /></li>
</xsl:template>


<xsl:template match="acteurDescription">
    <xsl:text> </xsl:text>
    <xsl:value-of select="prenom" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="nom" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="dateNaissance" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="count(/films/film[acteurs/acteur[@ref=current()/@id]])"/> 
    <br/>
</xsl:template>

</xsl:stylesheet>
