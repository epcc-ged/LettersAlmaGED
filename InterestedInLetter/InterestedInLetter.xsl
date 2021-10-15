<?xml version="1.0" encoding="utf-8"?>

<!-- this file: InterestedInLetter.xsl -->
<!-- Historique de mise à jour Campus Condorcet
	 2021-10-15 JCS : mise à jour de la lettre
-->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

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
					<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

				<br />
				<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td colspan="2">
							@@You_were_specify@@ :
						</td>
					</tr>
					<tr>
						<td>
							@@orderNumber@@	:
						</td>
						<td>
							<xsl:value-of  select="notification_data/line_number"/>
						</td>
					</tr>
					<tr>
						<td>
							@@title@@ :
						</td>
						<td>
							<xsl:value-of  select="notification_data/title"/>
						</td>
					</tr>
					<tr>
						<td>
							@@mmsId@@ :
	
						</td>
						<td>
							<xsl:value-of  select="notification_data/mms_id"/>
						</td>
					</tr>
					<tr>
						<td>
							@@callNumber@@	:
						</td>
						<td>
							<xsl:value-of  select="notification_data/poline_inventory/call_number"/>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							@@message@@	: <xsl:value-of  select="notification_data/message"/>
						</td>
					</tr>
				</table>
				<br />
				<table role='presentation' >
					<tr>
						<td>
							@@sincerely@@
						</td>
					</tr>
					<tr>
						<td>
							@@department@@
						</td>
					</tr>
				</table>

				<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>