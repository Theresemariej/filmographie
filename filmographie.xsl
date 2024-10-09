
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="iso-8859-1" indent="yes"/>


<xsl:template match="/">
<html><head><link rel="stylesheet" type="text/css" href="film.css" />
 <title> cinématographie </title> </head>
<body>
    <h1>Cinématographie</h1>
    <xsl:apply-templates select="films/film" />
</body>
</html>
</xsl:template>

<xsl:template match="film">
    <h2>
    <xsl:value-of select="nom" />
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

<xsl:template match="acteur">
<li><xsl:value-of select="." /></li>
</xsl:template>

</xsl:stylesheet>
