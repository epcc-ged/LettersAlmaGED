<?xml version="1.0" encoding="utf-8"?>

<!-- this file: footer.xsl -->
<!-- Historique de mise à jour Campus Condorcet
	 2021-04-28 JCS : refonte complète
	 2022-10-21 JCS : Le GED est renommé Humathèque
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- Ne pas supprimer la partie 'salutation', sinon cela plante certaines lettres -->
<xsl:template name="salutation">

</xsl:template>

<xsl:template name="lastFooter">
	<center>
		<table>
			<xsl:attribute name="style">
				<xsl:call-template name="footerTableStyleCss" /> 
			</xsl:attribute>
			<tr>
				<td>Humathèque - Condorcet</td>
			</tr>
			<tr>
				<td><a class="lienfooter" href="https://ged.campus-condorcet.fr">https://ged.campus-condorcet.fr</a></td>
			</tr>
		</table>
	</center>
</xsl:template>


<!-- Ne pas supprimer la partie 'myAccount', sinon cela plante certaines lettres -->
<xsl:template name="myAccount">

</xsl:template>

</xsl:stylesheet>