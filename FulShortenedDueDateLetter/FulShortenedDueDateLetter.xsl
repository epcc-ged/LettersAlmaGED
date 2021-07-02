<?xml version="1.0" encoding="utf-8"?>

<!-- this file: FulShortenedDueDateLetter.xsl -->
<!-- Historique de mise à jour Campus Condorcet
    2021-01-08 JCS : adaptation pour prise de rdv pendant le Covid
	2021-04-22 JCS : autres adaptations pour Covid et diverses mises à jour de forme et contenu
	2021-04-28 JCS : réactivation du footer
	2021-07-02 JCS : suppression lien evento COVID
-->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template match="/">
<html>
	<xsl:if test="notification_data/languages/string">
		<xsl:attribute name="lang">
			<xsl:value-of select="notification_data/languages/string"/>
		</xsl:attribute>
	</xsl:if>

	<head>
		<title>
			<xsl:value-of select="notification_data/general_data/subject"/>
		</title>

		<xsl:call-template name="generalStyle" />
	</head>
	<body>
        <xsl:attribute name="style">
			<xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head" /><!-- header.xsl -->
        <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

		<br />

		<xsl:call-template name="toWhomIsConcerned" />

        <div class="messageArea">
			<div class="messageBody">
				<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							Madame, Monsieur,
						</td>
					</tr>
					<tr>          
						<td>
							@@title@@
							<xsl:value-of select="notification_data/item_loan/shortened_due_date_reason"/>
						</td>
					</tr>
					<tr>
						<td>
							<xsl:value-of select="notification_data/item_loan/title"/>
						</td>
					</tr>
				</table>
				<br />
				<table role='presentation' >
					<tr><td>@@sincerely@@</td></tr>
					<tr><td>@@department@@</td></tr>
				</table>
			</div>
		</div>

        
		
        <xsl:call-template name="lastFooter" />
		
	</body>
</html>
 </xsl:template>
</xsl:stylesheet>
