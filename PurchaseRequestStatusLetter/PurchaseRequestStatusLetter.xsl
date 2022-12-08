<?xml version="1.0" encoding="utf-8"?>

<!-- this file: PurchaseRequestStatusLetter.xsl -->
<!-- Historique de mise à jour Campus Condorcet
     2020-05-20 JCS : adaptation pour gestion des différents motifs de rejet
	 2022-12-08 JCS : renommage GED en Humatheque
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
		<head>
			<xsl:call-template name="generalStyle" />
		</head>

			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

				<br />
				<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							@@introduction@@ 
							<xsl:if test="notification_data/purchase_request/author != ''">
								<xsl:value-of select="notification_data/purchase_request/author" />.
							</xsl:if>
							<em><xsl:value-of select="notification_data/purchase_request/title" /></em><br />
						</td>
					</tr>
					<tr>
						<td>
							<xsl:choose >
								<xsl:when test="/notification_data/purchase_request/request_status='APPROVED'">
									@@approved@@ <xsl:value-of select="notification_data/purchase_request/poline_reference" />.
								</xsl:when>
								<xsl:otherwise>
									
									<xsl:choose>
										<xsl:when test="notification_data/purchase_request/reject_reason='CAT_OK_SUPPORT'">
											<xsl:text>Nous vous en remercions, mais vous informons qu’il figure déjà au catalogue.</xsl:text>
										</xsl:when>
										<xsl:when test="notification_data/purchase_request/reject_reason='CAT_OK_ELEC'">
											<xsl:text>Nous vous en remercions. 
											Nous vous informons qu’il figure déjà au catalogue, en version électronique. 
											Sa consultation est ainsi possible immédiatement et à distance en vous authentifiant. 
											En cas de besoin, vous pouvez contacter services.humatheque@campus-condorcet.fr. 
											Néanmoins, si le support papier vous paraît indispensable, merci de refaire une demande d'achat en le précisant 
											dans la zone "Note du demandeur".</xsl:text>
										</xsl:when>
										<xsl:when test="notification_data/purchase_request/reject_reason='DEJA_EN_COMMANDE'">
											<xsl:text>Nous vous en remercions. 
											Ce document étant déjà en commande, votre nom a été ajouté à la notice de commande. 
											Vous serez donc prévenu lors de sa réception.</xsl:text>
										</xsl:when>
										<xsl:when test="notification_data/purchase_request/reject_reason='AUTRE_MOTIF'">
											<xsl:text>Nous vous en remercions. 
											Pour les raisons qui vous ont été précisées précédemment par mail, votre demande a dû être rejetée.</xsl:text>
										</xsl:when>
										<xsl:when test="notification_data/purchase_request/reject_reason='CANCELLED_BY_REQUESTER'">
											<xsl:text>Comme vous l'avez souhaité, elle a bien été annulée.</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>[Erreur technique] Si vous voyez ce message, veuillez contacter l'Humathèque en lui indiquant que vous avez reçu le présent email avec le motif : CODE INCONNU.</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</table>
				<br />
				<table>
						<tr><td>@@sincerely@@</td></tr>
						<tr><td>@@department@@</td></tr>
				</table>

				<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>